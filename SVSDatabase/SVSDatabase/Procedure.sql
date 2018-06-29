CREATE TABLE [dbo].[Procedure]
(
	[ProcedureID] INT NOT NULL,
	[Description] NVARCHAR(100) NOT NULL,
	[Price] MONEY NOT NULL,
	CONSTRAINT PK_PRO PRIMARY KEY (ProcedureID)
)
