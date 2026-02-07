# Skill: Delta Lake patterns

Design and evolve Delta Lake tables on S3 for analytical data, using append/merge patterns and safe schema evolution in line with project standards.

## When to use

- You are storing or processing analytical data in S3 and must use Delta Lake format.
- You need to design a new Delta table schema or evolve an existing one.
- You are implementing ingestion, merges, or updates over Delta tables.

## Steps

1. **Define schema up front** – Use a clear StructType (or equivalent) with types and nullability. Document partition columns and their meaning.
2. **Choose write pattern** – Prefer append for event/log data; use merge (upsert) when you have natural keys and need updates/deletes.
3. **Partitioning** – Partition by columns used in common filters (e.g. date, tenant_id). Avoid over-partitioning (many small files).
4. **Schema evolution** – Add new columns via `ALTER TABLE ... ADD COLUMN` or equivalent; avoid dropping or renaming columns in breaking ways. When appending with a new schema, use mergeSchema or explicit evolution options as supported.
5. **Paths** – Use hierarchical S3 keys (e.g. `lakehouse/raw/events/`, `lakehouse/curated/orders/`) and reference them consistently in code and docs.

## Do

- Use Delta Lake for all new analytical datasets in S3.
- Keep schemas explicit and documented; evolve only in backward-compatible ways when possible.
- Align with aws-s3: hierarchical keys, no large blobs in DynamoDB; use S3 for data, DynamoDB for metadata if needed.

## Do not

- Store analytical data as raw JSON/CSV in S3 when Delta is the standard.
- Change partition columns on existing tables without a migration plan.
- Expose S3 paths or credentials in code; use configuration or environment.

## Related rules

- `aws-s3`: Delta Lake as default for analytical data; hierarchical key organization; append/merge patterns.
