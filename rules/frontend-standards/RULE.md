---
description: "Frontend standards using React and TypeScript"
globs:
  - "src/**/*.{ts,tsx,js,jsx}"
  - "app/**/*.{ts,tsx,js,jsx}"
alwaysApply: false
---

# Frontend Rules (React)

## Purpose
Define standards for frontend development using React and TypeScript, ensuring maintainable, performant, and accessible user interfaces with clean separation of concerns.

## Constraints
- All React components must be implemented using **TypeScript**
- Use **functional components** with hooks (no class components)
- Use **React Query** (TanStack Query) for server state management and API calls
- Use **Zustand** or **React Context** for client-side state management (prefer Zustand for complex state)
- All API calls must go through a centralized API client layer
- Use **React Hook Form** for form management and validation
- Components must be accessible (WCAG 2.1 AA compliance)

## Component Organization
- Use a feature-based folder structure
- Keep components small and focused on a single responsibility
- Extract reusable logic into custom hooks
- Separate presentational and container components when appropriate

## Do
- Use TypeScript for all components and utilities
- Define clear prop types with TypeScript interfaces
- Use functional components with hooks
- Extract reusable logic into custom hooks
- Use React Query for all API calls and server state
- Handle loading and error states in all data fetching
- Implement proper error boundaries
- Use semantic HTML elements for accessibility
- Keep components small and focused (ideally < 200 lines)
- Use memoization (useMemo, useCallback) when appropriate
- Extract constants and magic numbers to named constants
- Validate HTTP status codes in all API responses
- Implement retry logic for transient failures
- Handle network errors gracefully with user-friendly messages
- Use exponential backoff for retry attempts

## Do Not
- Do not use class components
- Do not mix business logic with presentation logic
- Do not make direct API calls from components (use React Query)
- Do not use inline styles (use CSS modules, styled-components, or Tailwind)
- Do not skip error handling for async operations
- Do not create deeply nested component hierarchies
- Do not use `any` type in TypeScript
- Do not ignore accessibility requirements
- Do not store sensitive data in component state or localStorage

## Examples

### ✅ Good: Functional Component with TypeScript

```typescript
import React from 'react';

interface UserCardProps {
  userId: string;
  name: string;
  email: string;
  role: UserRole;
  onEdit?: (userId: string) => void;
}

export const UserCard: React.FC<UserCardProps> = ({
  userId,
  name,
  email,
  role,
  onEdit,
}) => {
  const handleEdit = () => {
    if (onEdit) {
      onEdit(userId);
    }
  };

  return (
    <article className="user-card">
      <h2>{name}</h2>
      <p>{email}</p>
      <span className="role-badge">{role}</span>
      {onEdit && (
        <button onClick={handleEdit} aria-label={`Edit user ${name}`}>
          Edit
        </button>
      )}
    </article>
  );
};
```

### ❌ Bad: Class Component or Missing Types

```typescript
// ❌ BAD: Class component or missing TypeScript types
class UserCard extends React.Component { ... }
export const UserCard = ({ userId, name, email }) => { ... };
```

### ✅ Good: Custom Hook for Reusable Logic

```typescript
import { useState, useCallback } from 'react';

interface UseToggleReturn {
  isOpen: boolean;
  open: () => void;
  close: () => void;
  toggle: () => void;
}

export const useToggle = (initialState = false): UseToggleReturn => {
  const [isOpen, setIsOpen] = useState(initialState);

  const open = useCallback(() => setIsOpen(true), []);
  const close = useCallback(() => setIsOpen(false), []);
  const toggle = useCallback(() => setIsOpen((prev) => !prev), []);

  return { isOpen, open, close, toggle };
};

// Usage in component
export const Modal: React.FC<ModalProps> = ({ children }) => {
  const { isOpen, open, close, toggle } = useToggle();

  return (
    <>
      <button onClick={open}>Open Modal</button>
      {isOpen && (
        <div role="dialog" aria-modal="true">
          {children}
          <button onClick={close}>Close</button>
        </div>
      )}
    </>
  );
};
```

### ✅ Good: React Query for API Calls

```typescript
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { userApi } from '@/services/api';

// Custom hook for user data
export const useUser = (userId: string) => {
  return useQuery({
    queryKey: ['user', userId],
    queryFn: () => userApi.getUser(userId),
    enabled: !!userId,
    staleTime: 5 * 60 * 1000, // 5 minutes
  });
};

// Custom hook for user list
export const useUsers = (filters?: UserFilters) => {
  return useQuery({
    queryKey: ['users', filters],
    queryFn: () => userApi.getUsers(filters),
  });
};

// Custom hook for creating user
export const useCreateUser = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: userApi.createUser,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });
};

// Usage in component
export const UserProfile: React.FC<{ userId: string }> = ({ userId }) => {
  const { data: user, isLoading, error } = useUser(userId);
  const createUserMutation = useCreateUser();

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  if (!user) return <div>User not found</div>;

  const handleCreate = () => {
    createUserMutation.mutate({
      name: 'New User',
      email: 'user@example.com',
    });
  };

  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
      <button onClick={handleCreate}>Create User</button>
    </div>
  );
};
```

### ❌ Bad: Direct API Calls in Components

```typescript
// ❌ BAD: Direct API calls, no error handling, no status validation
export const UserProfile = ({ userId }) => {
  useEffect(() => {
    fetch(`/api/users/${userId}`).then((res) => res.json()).then(setUser);
  }, [userId]);
  return <div>{user?.name}</div>;
};
```

### ✅ Good: Centralized API Client with Status Validation

```typescript
// services/api/client.ts
import axios, { AxiosError, AxiosResponse } from 'axios';

// HTTP status code constants
const HTTP_STATUS = {
  OK: 200,
  CREATED: 201,
  NO_CONTENT: 204,
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  CONFLICT: 409,
  INTERNAL_SERVER_ERROR: 500,
  SERVICE_UNAVAILABLE: 503,
} as const;

// Custom error class for API errors
export class ApiError extends Error {
  constructor(
    public status: number,
    public statusText: string,
    public data?: unknown
  ) {
    super(`API Error: ${status} ${statusText}`);
    this.name = 'ApiError';
  }
}

// Validate response status
const validateStatus = (response: AxiosResponse): AxiosResponse => {
  const { status } = response;
  
  // Success status codes
  if (status >= 200 && status < 300) {
    return response;
  }
  
  // Client errors (4xx)
  if (status >= 400 && status < 500) {
    throw new ApiError(
      status,
      response.statusText,
      response.data
    );
  }
  
  // Server errors (5xx)
  if (status >= 500) {
    throw new ApiError(
      status,
      response.statusText,
      response.data
    );
  }
  
  // Unexpected status codes
  throw new ApiError(status, response.statusText, response.data);
};

const apiClient = axios.create({
  baseURL: process.env.REACT_APP_API_BASE_URL || '/api/v1',
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 10000, // 10 seconds
});

// Request interceptor for auth tokens
apiClient.interceptors.request.use((config) => {
  const token = localStorage.getItem('access_token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Response interceptor with status validation and error handling
apiClient.interceptors.response.use(
  (response) => validateStatus(response),
  (error: AxiosError) => {
    // Network errors (no response from server)
    if (!error.response) {
      throw new ApiError(
        0,
        'Network Error',
        { message: 'Unable to reach server. Please check your connection.' }
      );
    }
    
    // HTTP errors with response
    const { status, statusText, data } = error.response;
    
    // Handle specific status codes
    if (status === HTTP_STATUS.UNAUTHORIZED) {
      localStorage.removeItem('access_token');
      window.location.href = '/login';
    }
    
    throw new ApiError(status, statusText, data);
  }
);

export default apiClient;

// services/api/userApi.ts
import apiClient from './client';
import { ApiError } from './client';

export interface User {
  id: string;
  name: string;
  email: string;
  role: string;
}

export interface CreateUserRequest {
  name: string;
  email: string;
  role?: string;
}

export const userApi = {
  getUser: async (userId: string): Promise<User> => {
    const response = await apiClient.get(`/users/${userId}`);
    // Response is already validated by interceptor
    return response.data;
  },

  getUsers: async (filters?: UserFilters): Promise<User[]> => {
    const response = await apiClient.get('/users', { params: filters });
    return response.data;
  },

  createUser: async (data: CreateUserRequest): Promise<User> => {
    const response = await apiClient.post('/users', data);
    return response.data;
  },

  updateUser: async (userId: string, data: Partial<User>): Promise<User> => {
    const response = await apiClient.put(`/users/${userId}`, data);
    return response.data;
  },

  deleteUser: async (userId: string): Promise<void> => {
    await apiClient.delete(`/users/${userId}`);
  },
};
```

### ✅ Good: React Hook Form for Forms

```typescript
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const userSchema = z.object({
  name: z.string().min(1, 'Name is required').max(100, 'Name too long'),
  email: z.string().email('Invalid email address'),
  role: z.enum(['admin', 'manager', 'analyst', 'viewer']),
});

type UserFormData = z.infer<typeof userSchema>;

export const UserForm: React.FC<{ onSubmit: (data: UserFormData) => void }> = ({
  onSubmit,
}) => {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<UserFormData>({
    resolver: zodResolver(userSchema),
  });

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div>
        <label htmlFor="name">Name</label>
        <input
          id="name"
          {...register('name')}
          aria-invalid={errors.name ? 'true' : 'false'}
          aria-describedby={errors.name ? 'name-error' : undefined}
        />
        {errors.name && (
          <span id="name-error" role="alert">
            {errors.name.message}
          </span>
        )}
      </div>

      <div>
        <label htmlFor="email">Email</label>
        <input
          id="email"
          type="email"
          {...register('email')}
          aria-invalid={errors.email ? 'true' : 'false'}
        />
        {errors.email && (
          <span role="alert">{errors.email.message}</span>
        )}
      </div>

      <div>
        <label htmlFor="role">Role</label>
        <select id="role" {...register('role')}>
          <option value="viewer">Viewer</option>
          <option value="analyst">Analyst</option>
          <option value="manager">Manager</option>
          <option value="admin">Admin</option>
        </select>
      </div>

      <button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Submitting...' : 'Submit'}
      </button>
    </form>
  );
};
```

### ❌ Bad: Uncontrolled Forms or Missing Validation

```typescript
// ❌ BAD: Uncontrolled form, no validation, no type safety
export const UserForm = () => {
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const data = Object.fromEntries(new FormData(e.target as HTMLFormElement));
    // No validation
  };
  return <form onSubmit={handleSubmit}><input name="name" /></form>;
};
```

### ✅ Good: Error Boundary

```typescript
import React, { Component, ErrorInfo, ReactNode } from 'react';

interface Props {
  children: ReactNode;
  fallback?: ReactNode;
}

interface State {
  hasError: boolean;
  error?: Error;
}

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
    // Log to error reporting service
  }

  render() {
    if (this.state.hasError) {
      return (
        this.props.fallback || (
          <div role="alert">
            <h2>Something went wrong</h2>
            <p>{this.state.error?.message}</p>
            <button onClick={() => this.setState({ hasError: false })}>
              Try again
            </button>
          </div>
        )
      );
    }

    return this.props.children;
  }
}

// Usage
export const App: React.FC = () => {
  return (
    <ErrorBoundary>
      <UserProfile userId="123" />
    </ErrorBoundary>
  );
};
```

### ✅ Good: Zustand for Client State

```typescript
// stores/userStore.ts
import { create } from 'zustand';
import { devtools } from 'zustand/middleware';

interface UserState {
  currentUser: User | null;
  setCurrentUser: (user: User | null) => void;
  clearUser: () => void;
}

export const useUserStore = create<UserState>()(
  devtools(
    (set) => ({
      currentUser: null,
      setCurrentUser: (user) => set({ currentUser: user }),
      clearUser: () => set({ currentUser: null }),
    }),
    { name: 'user-store' }
  )
);

// Usage in component
export const UserProfile: React.FC = () => {
  const { currentUser, setCurrentUser } = useUserStore();
  const { data: user } = useUser('123');

  useEffect(() => {
    if (user) {
      setCurrentUser(user);
    }
  }, [user, setCurrentUser]);

  return <div>{currentUser?.name}</div>;
};
```

### ✅ Good: Memoization for Performance

```typescript
import { useMemo, useCallback } from 'react';

export const UserList: React.FC<{ users: User[]; filter: string }> = ({
  users,
  filter,
}) => {
  // Memoize filtered users
  const filteredUsers = useMemo(() => {
    return users.filter((user) =>
      user.name.toLowerCase().includes(filter.toLowerCase())
    );
  }, [users, filter]);

  // Memoize callback
  const handleUserClick = useCallback((userId: string) => {
    console.log('User clicked:', userId);
    // Navigate or perform action
  }, []);

  return (
    <ul>
      {filteredUsers.map((user) => (
        <li key={user.id} onClick={() => handleUserClick(user.id)}>
          {user.name}
        </li>
      ))}
    </ul>
  );
};
```

### ✅ Good: Accessibility

```typescript
export const AccessibleButton: React.FC<{
  onClick: () => void;
  children: React.ReactNode;
  variant?: 'primary' | 'secondary';
}> = ({ onClick, children, variant = 'primary' }) => {
  return (
    <button
      onClick={onClick}
      className={`btn btn-${variant}`}
      aria-label={typeof children === 'string' ? children : undefined}
      type="button"
    >
      {children}
    </button>
  );
};

export const AccessibleModal: React.FC<{
  isOpen: boolean;
  onClose: () => void;
  title: string;
  children: React.ReactNode;
}> = ({ isOpen, onClose, title, children }) => {
  useEffect(() => {
    if (isOpen) {
      // Trap focus within modal
      const firstFocusable = document.querySelector(
        '[tabindex], button, [href], input, select, textarea'
      ) as HTMLElement;
      firstFocusable?.focus();
    }
  }, [isOpen]);

  if (!isOpen) return null;

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="modal-title"
      className="modal-overlay"
      onClick={onClose}
    >
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <h2 id="modal-title">{title}</h2>
        {children}
        <button onClick={onClose} aria-label="Close modal">
          Close
        </button>
      </div>
    </div>
  );
};
```

### ✅ Good: Feature-Based Folder Structure

```
src/
├── features/
│   ├── users/
│   │   ├── components/
│   │   │   ├── UserCard.tsx
│   │   │   └── UserList.tsx
│   │   ├── hooks/
│   │   │   ├── useUser.ts
│   │   │   └── useUsers.ts
│   │   ├── types/
│   │   │   └── user.types.ts
│   │   └── index.ts
│   └── auth/
│       ├── components/
│       ├── hooks/
│       └── types/
├── services/
│   ├── api/
│   │   ├── client.ts
│   │   └── userApi.ts
│   └── storage/
├── shared/
│   ├── components/
│   │   ├── Button.tsx
│   │   └── Modal.tsx
│   ├── hooks/
│   └── utils/
├── stores/
│   └── userStore.ts
└── App.tsx
```

### ❌ Bad: Flat or Type-Based Structure

```
// ❌ BAD: Flat structure makes it hard to find related code
src/
├── components/  // All components mixed together
├── hooks/       // All hooks mixed together
└── types/       // All types mixed together
```

### ✅ Good: Constants Extraction

```typescript
// constants/api.ts
export const API_ENDPOINTS = {
  USERS: '/v1/users',
  AUTH: '/v1/auth',
  ORDERS: '/v1/orders',
} as const;

// constants/roles.ts
export const USER_ROLES = {
  ADMIN: 'admin',
  MANAGER: 'manager',
  ANALYST: 'analyst',
  VIEWER: 'viewer',
} as const;

export type UserRole = typeof USER_ROLES[keyof typeof USER_ROLES];

// Usage
import { API_ENDPOINTS, USER_ROLES } from '@/constants';

export const userApi = {
  getUsers: () => apiClient.get(API_ENDPOINTS.USERS),
};
```

### ❌ Bad: Magic Numbers and Hardcoded Values

```typescript
// ❌ BAD: Magic numbers, hardcoded values, no status validation
export const UserList = () => {
  const users = useQuery({
    queryFn: () => fetch('/api/v1/users').then((r) => r.json()), // No status check
    staleTime: 300000, // What is 300000?
  });
  return <div>{users.data?.map((u) => u.role === 'admin' && <span>Admin</span>)}</div>;
};
```

### ✅ Good: API Call Resilience with Retry Logic

```typescript
import { useQuery, useMutation } from '@tanstack/react-query';
import { userApi, ApiError } from '@/services/api';

// Retry configuration constants
const RETRY_CONFIG = {
  MAX_RETRIES: 3,
  RETRY_DELAY: 1000, // 1 second base delay
  RETRYABLE_STATUS_CODES: [408, 429, 500, 502, 503, 504], // Retry on these status codes
} as const;

// Exponential backoff helper
const getRetryDelay = (attemptIndex: number): number => {
  return RETRY_CONFIG.RETRY_DELAY * Math.pow(2, attemptIndex);
};

// Custom retry function
const shouldRetry = (failureCount: number, error: unknown): boolean => {
  if (failureCount >= RETRY_CONFIG.MAX_RETRIES) {
    return false;
  }
  
  if (error instanceof ApiError) {
    // Only retry on retryable status codes
    return RETRY_CONFIG.RETRYABLE_STATUS_CODES.includes(error.status);
  }
  
  // Retry on network errors (status 0)
  if (error instanceof ApiError && error.status === 0) {
    return true;
  }
  
  return false;
};

// Custom hook with retry logic
export const useUser = (userId: string) => {
  return useQuery({
    queryKey: ['user', userId],
    queryFn: () => userApi.getUser(userId),
    enabled: !!userId,
    retry: shouldRetry,
    retryDelay: getRetryDelay,
    staleTime: 5 * 60 * 1000,
  });
};

// Mutation with retry logic
export const useCreateUser = () => {
  return useMutation({
    mutationFn: userApi.createUser,
    retry: shouldRetry,
    retryDelay: getRetryDelay,
  });
};
```

### ✅ Good: Error Handling with Status Code Validation

```typescript
import { useQuery } from '@tanstack/react-query';
import { userApi, ApiError, HTTP_STATUS } from '@/services/api';

export const useUserWithErrorHandling = (userId: string) => {
  return useQuery({
    queryKey: ['user', userId],
    queryFn: async () => {
      try {
        return await userApi.getUser(userId);
      } catch (error) {
        if (error instanceof ApiError) {
          // Handle specific status codes
          switch (error.status) {
            case HTTP_STATUS.NOT_FOUND:
              throw new Error('User not found');
            case HTTP_STATUS.FORBIDDEN:
              throw new Error('You do not have permission to view this user');
            case HTTP_STATUS.UNAUTHORIZED:
              throw new Error('Please log in to continue');
            case HTTP_STATUS.SERVICE_UNAVAILABLE:
              throw new Error('Service temporarily unavailable. Please try again later.');
            default:
              throw new Error(`Failed to load user: ${error.statusText}`);
          }
        }
        throw error;
      }
    },
    enabled: !!userId,
  });
};

// Usage in component with user-friendly error messages
export const UserProfile: React.FC<{ userId: string }> = ({ userId }) => {
  const { data: user, isLoading, error } = useUserWithErrorHandling(userId);

  if (isLoading) return <div>Loading user...</div>;
  
  if (error) {
    return (
      <div role="alert" className="error-message">
        <p>{error.message}</p>
        <button onClick={() => window.location.reload()}>Retry</button>
      </div>
    );
  }

  if (!user) return <div>User not found</div>;

  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </div>
  );
};
```

### ✅ Good: Network Error Recovery

```typescript
import { useQuery, useMutation } from '@tanstack/react-query';
import { userApi, ApiError } from '@/services/api';

// Check if error is retryable
const isRetryableError = (error: unknown): boolean => {
  if (error instanceof ApiError) {
    // Network errors (status 0) are retryable
    if (error.status === 0) return true;
    // Server errors (5xx) are retryable
    if (error.status >= 500 && error.status < 600) return true;
    // Rate limiting (429) is retryable
    if (error.status === 429) return true;
  }
  return false;
};

// Custom hook with network error recovery
export const useUsersWithRecovery = () => {
  return useQuery({
    queryKey: ['users'],
    queryFn: userApi.getUsers,
    retry: (failureCount, error) => {
      if (failureCount >= 3) return false;
      return isRetryableError(error);
    },
    retryDelay: (attemptIndex) => Math.min(1000 * Math.pow(2, attemptIndex), 30000),
    onError: (error) => {
      if (error instanceof ApiError && error.status === 0) {
        // Log network error for monitoring
        console.error('Network error detected:', error);
        // Could trigger offline mode notification
      }
    },
  });
};
```
