﻿/*
Deployment script for SVSDatabase

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar LoadTestData "true"
:setvar DatabaseName "SVSDatabase"
:setvar DefaultFilePrefix "SVSDatabase"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
PRINT N'Creating [dbo].[Owner]...';


GO
CREATE TABLE [dbo].[Owner] (
    [OwnerID]   INT           NOT NULL,
    [Surname]   NVARCHAR (50) NOT NULL,
    [GivenName] NVARCHAR (50) NOT NULL,
    [Phone]     INT           NOT NULL,
    CONSTRAINT [PK_OWNER] PRIMARY KEY CLUSTERED ([OwnerID] ASC)
);


GO
PRINT N'Creating [dbo].[Pet]...';


GO
CREATE TABLE [dbo].[Pet] (
    [PetID]   INT           NOT NULL,
    [OwnerID] INT           NOT NULL,
    [Name]    NVARCHAR (50) NULL,
    [Type]    NVARCHAR (50) NULL,
    CONSTRAINT [PK_PET] PRIMARY KEY CLUSTERED ([PetID] ASC),
    CONSTRAINT [U_PET] UNIQUE NONCLUSTERED ([PetID] ASC, [OwnerID] ASC)
);


GO
PRINT N'Creating [dbo].[Procedure]...';


GO
CREATE TABLE [dbo].[Procedure] (
    [ProcedureID] INT            NOT NULL,
    [Description] NVARCHAR (100) NOT NULL,
    [Price]       MONEY          NOT NULL,
    CONSTRAINT [PK_PRO] PRIMARY KEY CLUSTERED ([ProcedureID] ASC)
);


GO
PRINT N'Creating [dbo].[Treatment]...';


GO
CREATE TABLE [dbo].[Treatment] (
    [ProcedureID] INT           NOT NULL,
    [PetID]       INT           NOT NULL,
    [Date]        DATE          NOT NULL,
    [Notes]       NVARCHAR (50) NOT NULL,
    [Price]       MONEY         NOT NULL,
    CONSTRAINT [PK_TREATMENT] PRIMARY KEY CLUSTERED ([ProcedureID] ASC, [PetID] ASC, [Date] ASC)
);


GO
PRINT N'Creating [dbo].[FK_OWNER]...';


GO
ALTER TABLE [dbo].[Pet] WITH NOCHECK
    ADD CONSTRAINT [FK_OWNER] FOREIGN KEY ([OwnerID]) REFERENCES [dbo].[Owner] ([OwnerID]);


GO
PRINT N'Creating [dbo].[PK_PROCEDURE]...';


GO
ALTER TABLE [dbo].[Treatment] WITH NOCHECK
    ADD CONSTRAINT [PK_PROCEDURE] FOREIGN KEY ([ProcedureID]) REFERENCES [dbo].[Procedure] ([ProcedureID]);


GO
PRINT N'Creating [dbo].[FK_PET]...';


GO
ALTER TABLE [dbo].[Treatment] WITH NOCHECK
    ADD CONSTRAINT [FK_PET] FOREIGN KEY ([PetID]) REFERENCES [dbo].[Pet] ([PetID]);


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF '$(LoadTestData)' = 'true'

BEGIN

DELETE FROM Treatment;
DELETE FROM Pet;
DELETE FROM [Owner];
DELETE FROM [Procedure];

INSERT INTO [Owner] (OwnerID, Surname, GivenName, Phone) VALUES
(1, 'Sinatra', 'Frank', 400111222),
(2, 'Ellington', 'Duke', 400222333),
(3, 'Fitzgerald', 'Ella', 400333444);

INSERT INTO [Procedure] (ProcedureID, [Description], Price) VALUES
(01, 'Rabies Vaccination', 24),
(10, 'Examine and Treat Wound', 30),
(05, 'Heart Worm Test', 25),
(08, 'Tetnus Vaccination', 17);

INSERT INTO Pet(PetID, OwnerID,[Name], [Type]) VALUES
(1, 1, 'Buster', 'Dog'),
(2, 1,'Fluffy', 'Cat'),
(3, 2,'Stew', 'Rabbit'),
(4, 3,'Buster', 'Dog'),
(5, 3,'Pooper', 'Dog');

INSERT INTO Treatment(ProcedureID, PetID, [Date], Notes, Price) VALUES
(01, 1, '2017-06-20', 'Routine Vaccination', 22),
(01, 1, '2018-05-15', 'Booster Shot', 24),
(10, 2, '2018-05-10', 'Wounds sustained in apparent cat fight.', 30 ),
(10, 3, '2018-05-10', 'Wounds sustained during attemot to cook the stew.', 30),
(05, 5, '2018-05-18', 'Routine Test', 25);

END
GO

GO
