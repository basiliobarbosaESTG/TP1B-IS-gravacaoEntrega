SELECT unnest(XPATH('/athletes/atlethe[@name="A Lamusi"]', xml)) FROM xmldata;

SELECT unnest(XPATH('/athletes/atlethe/sex', xml)) FROM xmldata;
SELECT unnest(XPATH('/athletes/atlethe/age', xml)) FROM xmldata;

WITH athelete_info_name AS (
   SELECT unnest(XPATH('/athletes/atlethe/age', xml)) AS idadeAtleta
    FROM xmldata
), athelete_sex_info AS (
    SELECT unnest(XPATH('/athletes/atlethe/sex', xml)) AS sexoAtleta
     FROM xmldata
)

SELECT unnest(XPATH('/athletes/atlethe[@name="A Lamusi"]', xml)) AS nomeAtleta
    FROM xmldata;
	
SELECT unnest(xpath('/athletes/atlethe[@name="A Lamusi"]', xml)) AS nome,
        unnest(xpath('/athletes/atlethe/sex', xml)) AS sexo,
        unnest(xpath('/athletes/atlethe/age', xml)) AS idade
FROM xmldata;

------------------------------------------------------------------------------


WITH athelete_info_name AS (
   SELECT unnest(XPATH('/athletes/atlethe/age', xml)) AS idadeAtleta
    FROM xmldata
), athelete_sex_info AS (
    SELECT unnest(XPATH('/athletes/atlethe/sex', xml)) AS sexoAtleta
     FROM xmldata
)
	
WITH xmldataTemp (averageValue) as
    (SELECT avg(Attr1)
    FROM Table)
    SELECT Attr1
    FROM Table, temporaryTable
    WHERE Table.Attr1 > temporaryTable.averageValue;
	
--WITH xmldataTemp (averageValue) as
--    (SELECT avg(Attr1)
--    FROM Table)
--    SELECT Attr1
--    FROM Table, temporaryTable
--    WHERE Table.Attr1 > temporaryTable.averageValue;


SELECT CustomerID, CustomerName, Address
FROM xmldata(@hDoc, 'ROOT/Customers/Customer')
WITH 
(
CustomerID [varchar](50) '@CustomerID',
CustomerName [varchar](100) '@CustomerName',
Address [varchar](100) 'Address'
)