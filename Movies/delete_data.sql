use DKMovies

-- Disable constraints and delete data safely from all user tables

-- Step 1: Disable foreign key constraints
EXEC sp_MSforeachtable '
    PRINT ''Disabling constraints on ?'';
    EXEC(''ALTER TABLE ? NOCHECK CONSTRAINT ALL'')
';

-- Step 2: Delete data with proper SET options per execution
EXEC sp_MSforeachtable '
    PRINT ''Deleting data from ?'';
    EXEC(''
        SET QUOTED_IDENTIFIER ON;
        SET ANSI_NULLS ON;
        SET ANSI_WARNINGS ON;
        SET CONCAT_NULL_YIELDS_NULL ON;
        SET ARITHABORT ON;
        DELETE FROM ?
    '')
';

-- Step 3: Reset identity columns (optional)
EXEC sp_MSforeachtable '
    IF OBJECTPROPERTY(OBJECT_ID(''?''), ''TableHasIdentity'') = 1
    BEGIN
        PRINT ''Resetting identity on ?'';
        DBCC CHECKIDENT(''?'', RESEED, 0)
    END
';

-- Step 4: Re-enable constraints
EXEC sp_MSforeachtable '
    PRINT ''Re-enabling constraints on ?'';
    EXEC(''ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'')
';
