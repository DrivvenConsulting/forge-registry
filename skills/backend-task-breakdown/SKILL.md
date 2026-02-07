# Skill: Backend task breakdown

Break functional requirements and user stories into small, backend-executable tasks that align with project rules (architecture-decoupling, framework-fastapi).

## When to use

- A user story or acceptance criteria is broad or ambiguous.
- You need to plan API endpoints, services, and tests before implementing.
- You are creating sub-issues or a task list for backend work.

## Steps

1. **Extract scope** – From the user story or acceptance criteria, list every capability the backend must provide (auth, validation, persistence, notifications, etc.).
2. **Map to layers** – For each capability, assign:
   - **API**: route(s), method(s), request/response models (Pydantic).
   - **Service**: business logic; keep endpoints thin and delegate to services.
   - **Data**: repository or data access; depend on abstractions (protocols), not concrete implementations.
3. **Identify dependencies** – Order tasks so that repositories and services exist before endpoints that use them.
4. **Add tests** – For each service and endpoint, add a corresponding test (pytest, mirroring `tests/` structure).
5. **Optional sub-issues** – If using GitHub issues, create one sub-issue per coherent task (e.g. “[dev] Add GET /users/{id} and UserService.get_user”) so each can be implemented and reviewed independently.

## Do

- One task = one clear outcome (e.g. one endpoint + service method + tests).
- Name tasks after behavior, not implementation detail.
- Respect rules: thin endpoints, dependency injection, protocols for repositories.

## Do not

- Put business logic in route handlers.
- Create tasks that mix multiple endpoints or services.
- Skip tests or leave “add tests” as a single vague task.

## Related rules

- `architecture-decoupling`: dependency inversion, thin endpoints, service layer.
- `framework-fastapi`: request/response models, validation, dependency injection.
