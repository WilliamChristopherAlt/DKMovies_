USE DKMovies;
GO

-- Disable all constraints to avoid dependency errors
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT ALL"

-- Drop all foreign key constraints
DECLARE @sql NVARCHAR(MAX) = ''

SELECT @sql += 'ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + fk.name + '];'
FROM sys.foreign_keys fk
JOIN sys.tables t ON fk.parent_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id

EXEC sp_executesql @sql

-- Drop all tables
SET @sql = ''

SELECT @sql += 'DROP TABLE [' + s.name + '].[' + t.name + '];'
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id

EXEC sp_executesql @sql
