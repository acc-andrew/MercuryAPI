USE [master]
GO
/****** Object:  Database [MercuryDB]    Script Date: 2025/3/21 下午 05:35:11 ******/
CREATE DATABASE [MercuryDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MercuryDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MercuryDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MercuryDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MercuryDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MercuryDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MercuryDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MercuryDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MercuryDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MercuryDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MercuryDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MercuryDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MercuryDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MercuryDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MercuryDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MercuryDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MercuryDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MercuryDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MercuryDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MercuryDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MercuryDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MercuryDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MercuryDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MercuryDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MercuryDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MercuryDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MercuryDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MercuryDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MercuryDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MercuryDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MercuryDB] SET  MULTI_USER 
GO
ALTER DATABASE [MercuryDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MercuryDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MercuryDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MercuryDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MercuryDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MercuryDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MercuryDB', N'ON'
GO
ALTER DATABASE [MercuryDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [MercuryDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MercuryDB]
GO
/****** Object:  User [MercuryUser]    Script Date: 2025/3/21 下午 05:35:12 ******/
CREATE USER [MercuryUser] FOR LOGIN [MercuryUser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [MercuryUser]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2025/3/21 下午 05:35:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[DepartmentId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Myoffice_ACPD]    Script Date: 2025/3/21 下午 05:35:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Myoffice_ACPD](
	[acpd_sid] [char](20) NOT NULL,
	[acpd_cname] [nvarchar](40) NULL,
	[acpd_sname] [nvarchar](40) NULL,
	[acpd_email] [nvarchar](60) NULL,
	[acpd_status] [tinyint] NULL,
	[acpd_stop] [bit] NULL,
	[acpd_stopMemo] [nvarchar](600) NULL,
	[acpd_LoginID] [nvarchar](30) NULL,
	[acpd_LoginPW] [nvarchar](60) NULL,
	[acpd_memo] [nvarchar](120) NULL,
	[acpd_nowdatetime] [datetime] NULL,
	[appd_nowid] [nvarchar](20) NULL,
	[acpd_upddatetitme] [datetime] NULL,
	[acpd_updid] [nvarchar](20) NULL,
	[acpd_ename] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[createMyofficeACPD]    Script Date: 2025/3/21 下午 05:35:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[createMyofficeACPD]
    @InputJSON NVARCHAR(MAX),
    @StatusOutput INT OUTPUT
AS
BEGIN
    BEGIN TRY
        -- 建立臨時表儲存 JSON 解析結果
        CREATE TABLE #TempACPD
        (
            acpd_sid CHAR(20),
            acpd_cname NVARCHAR(40),
            acpd_ename NVARCHAR(40),
            acpd_email NVARCHAR(60),
            acpd_status TINYINT,
            acpd_stop BIT,
            acpd_stopMemo NVARCHAR(600),
            acpd_LoginID NVARCHAR(30),
            acpd_LoginPW NVARCHAR(30),
            acpd_memo NVARCHAR(120),
            acpd_nowdatetime DATETIME,
            appd_nowid NVARCHAR(20),
            acpd_upddatetitme DATETIME,
            acpd_updid NVARCHAR(20)
        );

        -- 將 JSON 資料解析並插入臨時表
        INSERT INTO #TempACPD (acpd_sid, acpd_cname, acpd_ename, acpd_email,
                               acpd_status, acpd_stop, acpd_stopMemo, acpd_LoginID, acpd_LoginPW,
                               acpd_memo, acpd_nowdatetime, appd_nowid, acpd_upddatetitme, acpd_updid)
        SELECT 
            acpd_sid, acpd_cname, acpd_ename, acpd_email,
            acpd_status, acpd_stop, acpd_stopMemo, acpd_LoginID, acpd_LoginPW,
            acpd_memo, acpd_nowdatetime, appd_nowid, acpd_upddatetitme, acpd_updid
        FROM 
            OPENJSON(@InputJSON, '$.Myoffice_ACPD')
            WITH (
                acpd_sid CHAR(20) '$.acpd_sid', -- 修正為 CHAR(20) 以匹配臨時表
                acpd_cname NVARCHAR(40) '$.acpd_cname',
                acpd_ename NVARCHAR(40) '$.acpd_ename', -- 修正 JSON 鍵名稱
                acpd_email NVARCHAR(60) '$.acpd_email',
                acpd_status TINYINT '$.acpd_status',
                acpd_stop BIT '$.acpd_stop',
                acpd_stopMemo NVARCHAR(600) '$.acpd_stopMemo',
                acpd_LoginID NVARCHAR(30) '$.acpd_LoginID',
                acpd_LoginPW NVARCHAR(30) '$.acpd_LoginPW', -- 修正資料類型一致性
                acpd_memo NVARCHAR(120) '$.acpd_memo',
                acpd_nowdatetime DATETIME '$.acpd_nowdatetime',
                appd_nowid NVARCHAR(20) '$.appd_nowid',
                acpd_upddatetitme DATETIME '$.acpd_upddatetitme',
                acpd_updid NVARCHAR(20) '$.acpd_updid'
            );

        -- 將臨時表中的資料插入 Myoffice_ACPD 表（僅插入新資料）
        INSERT INTO Myoffice_ACPD (acpd_sid, acpd_cname, acpd_ename, acpd_email,
                                   acpd_status, acpd_stop, acpd_stopMemo, acpd_LoginID, acpd_LoginPW,
                                   acpd_memo, acpd_nowdatetime, appd_nowid, acpd_upddatetitme, acpd_updid)
        SELECT 
            t.acpd_sid,
            t.acpd_cname,
            t.acpd_ename,
            t.acpd_email,
            t.acpd_status,
            t.acpd_stop,
            t.acpd_stopMemo,
            t.acpd_LoginID,
            t.acpd_LoginPW,
            t.acpd_memo,
            t.acpd_nowdatetime, 
            t.appd_nowid, 
            t.acpd_upddatetitme,
            t.acpd_updid 
        FROM 
            #TempACPD t
        WHERE 
            NOT EXISTS (
                SELECT 1 
                FROM Myoffice_ACPD e 
                WHERE e.acpd_sid = t.acpd_sid
            );

        -- 設定成功狀態
        SET @StatusOutput = 1;

        -- 清理臨時表
        DROP TABLE #TempACPD;
    END TRY
    BEGIN CATCH
        -- 錯誤處理
        SET @StatusOutput = -1;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmployeeDataWithJSON]    Script Date: 2025/3/21 下午 05:35:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetEmployeeDataWithJSON]
    @DepartmentId INT,
    @OutputJSON NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- 將查詢結果轉為 JSON
    SELECT @OutputJSON = (
        SELECT 
            e.EmployeeId,
            e.FirstName,
            e.LastName,
            e.DepartmentId,
            d.DepartmentName
        FROM 
            Employees e
            INNER JOIN Departments d ON e.DepartmentId = d.DepartmentId
        WHERE 
            e.DepartmentId = @DepartmentId
        FOR JSON PATH, ROOT('Employees')
    );
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_ProcessEmployeeJSON]    Script Date: 2025/3/21 下午 05:35:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ProcessEmployeeJSON]
    @InputJSON NVARCHAR(MAX),
    @StatusOutput INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- 建立臨時表儲存 JSON 解析結果
        CREATE TABLE #TempEmployee
        (
            EmployeeId INT,
            FirstName NVARCHAR(50),
            LastName NVARCHAR(50),
            DepartmentId INT
        );

		DECLARE @EmpIDLocal  INT
		DECLARE @FirstNameLocal NVARCHAR(50)
		DECLARE @LastNameLocal NVARCHAR(50)
		DECLARE @DepartmentIdLocal INT

        -- 將 JSON 資料解析並插入臨時表
        INSERT INTO #TempEmployee (EmployeeId, FirstName, LastName, DepartmentId)

        SELECT 
            EmployeeId,
            FirstName,
            LastName,
            DepartmentId
        FROM 
            OPENJSON(@InputJSON, '$.Employees')
            WITH (
                EmployeeId INT '$.EmployeeId',
                FirstName NVARCHAR(50) '$.FirstName',
                LastName NVARCHAR(50) '$.LastName',
                DepartmentId INT '$.DepartmentId'
            );

			-- 將臨時表中的資料插入 Employees 表（僅插入新資料）
        INSERT INTO Employees (EmployeeId, FirstName, LastName, DepartmentId)
        SELECT 
			t.EmployeeId,
            t.FirstName,
            t.LastName,
            t.DepartmentId
        FROM 
            #TempEmployee t
        WHERE 
            NOT EXISTS (
                SELECT 1 
                FROM Employees e 
                WHERE e.EmployeeId = t.EmployeeId
            );
        -- 在這裡可以加入您的業務邏輯
        -- 例如：更新員工資料
        UPDATE e
        SET 
            e.FirstName = t.FirstName,
            e.LastName = t.LastName,
            e.DepartmentId = t.DepartmentId
        FROM 
            Employees e
            INNER JOIN #TempEmployee t ON e.EmployeeId = t.EmployeeId;

      		  -- 加入資料 


        -- 設定成功狀態
        SET @StatusOutput = 1;

        -- 清理臨時表
        DROP TABLE #TempEmployee;
    END TRY
    BEGIN CATCH
        -- 錯誤處理
        SET @StatusOutput = -1;
        THROW;
    END CATCH
END;
GO
USE [master]
GO
ALTER DATABASE [MercuryDB] SET  READ_WRITE 
GO
