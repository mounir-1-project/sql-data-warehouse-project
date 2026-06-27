
/*
==================================================================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)
==================================================================================
Script Purpose :
This stored precedure loads data into the 'bronze ' shema from external CSV files .
It perfoms the following actions :
- Truncates the bronze tables before loading data .
- Uses the 'BULK INSERT ' command to load data from csv files to bronze tables .

Parametres :
   Noe .
   This stored procedure does not accept any parametrs or return any values .

Usage Example :
   EXEC bronze.load_bronze;
==================================================================================
*/
CREATE OR ALTER   PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME , @end_time DATETIME , @start_time_module DATETIME , @end_time_module DATETIME /*declaration des variables */
    BEGIN TRY 
        PRINT '============================='
        PRINT 'LOADING BRONZE LAYER  '

        SET @start_time_module = GETDATE();
        PRINT '============================='
        PRINT 'LOADING THE CRM TABLES  '

        SET @start_time = GETDATE(); /*initialisation de la variable start_time avec la date actuelle */
        PRINT '------------------------------------'
        PRINT 'LOADING crm_cust_info TABLE'

        TRUNCATE TABLE bronze.crm_cust_info; /*pour vider(ecraser) le tableau */
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\mouni\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2 ,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        SET @end_time = GETDATE(); /*initialisation de la variable end_time avec la date actuelle */
        /* DATEDIFF(THE_UNIT,FIRST_OPERANT,SECOND_OPERANT) : calculates the difference between two dates , returns days , mounths , or years */
        PRINT 'la duree de loading de crm_cust_info etait '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds '

        SET @start_time = GETDATE();
        PRINT '------------------------------------'
        PRINT 'LOADING crm_prd_info TABLE'
        TRUNCATE TABLE bronze.crm_prd_info; /*pour vider(ecraser) le tableau */
        BULK INSERT bronze.crm_prd_info 
        FROM 'C:\Users\mouni\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2 ,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        SET @end_time = GETDATE();
        PRINT 'la duree de loading de crm_prd_info etait '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds '

        SET @start_time = GETDATE();
        PRINT '------------------------------------'
        PRINT 'LOADING crm_prd_info TABLE'
        TRUNCATE TABLE bronze.crm_sales_details; /*pour vider(ecraser) le tableau */
        BULK INSERT bronze.crm_sales_details 
        FROM 'C:\Users\mouni\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2 ,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        SET @end_time = GETDATE();
        PRINT 'la duree de loading de crm_sales_details etait '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds '
        SET @end_time_module = GETDATE()
        PRINT 'la duree de loading des tableaux CRM EST : '+ CAST(DATEDIFF(second,@start_time_module,@end_time_module ) AS NVARCHAR ) + 'seconds '

        SET @start_time_module = GETDATE();
        PRINT '============================='
        PRINT 'LOADING THE ERP TABLES  '

        SET @start_time = GETDATE();
        PRINT '------------------------------------'
        PRINT 'LOADING erp_cust_az12 TABLE'
        TRUNCATE TABLE bronze.erp_cust_az12; /*pour vider(ecraser) le tableau */
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\mouni\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2 ,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        SET @end_time = GETDATE();
        PRINT 'la duree de loading de erp_cust_az12 etait '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds '

        SET @start_time = GETDATE();
        PRINT '------------------------------------'
        PRINT 'LOADING erp_loc_a101 TABLE'
        TRUNCATE TABLE bronze.erp_loc_a101; /*pour vider(ecraser) le tableau */
        BULK INSERT bronze.erp_loc_a101 
        FROM 'C:\Users\mouni\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2 ,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        SET @end_time = GETDATE();
        PRINT 'la duree de loading de erp_loc_a101 etait '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds '

        SET @end_time = GETDATE();
        PRINT '------------------------------------'
        PRINT 'LOADING erp_px_cat_g1v2 TABLE'
        TRUNCATE TABLE bronze.erp_px_cat_g1v2; /*pour vider(ecraser) le tableau */
        BULK INSERT bronze.erp_px_cat_g1v2 
        FROM 'C:\Users\mouni\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2 ,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        SET @end_time = GETDATE();
        PRINT 'la duree de loading de erp_px_cat_g1v2 etait '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds '
        SET @end_time_module = GETDATE()
        PRINT 'la duree de loading des tableaux CRM EST : '+ CAST(DATEDIFF(second,@start_time_module,@end_time_module ) AS NVARCHAR ) + 'seconds '


    END TRY 
    BEGIN CATCH 
        PRINT '==============================='
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER '
        PRINT 'Error Message '+ ERROR_MESSAGE();
        PRINT 'Error Message '+ CAST(ERROR_NUMBER() AS NVARCHAR) ;
        PRINT 'Error Message '+ CAST(ERROR_STATE() AS NVARCHAR) ;
        PRINT '==============================='
    END CATCH 
END
