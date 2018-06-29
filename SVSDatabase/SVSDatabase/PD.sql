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