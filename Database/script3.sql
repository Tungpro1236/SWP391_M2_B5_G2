USE [master]
GO
/****** Object:  Database [Onlinelearning]    Script Date: 4/15/2025 11:21:22 PM ******/
CREATE DATABASE [Onlinelearning]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Onlinelearning', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Onlinelearning.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Onlinelearning_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Onlinelearning_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Onlinelearning] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Onlinelearning].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Onlinelearning] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Onlinelearning] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Onlinelearning] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Onlinelearning] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Onlinelearning] SET ARITHABORT OFF 
GO
ALTER DATABASE [Onlinelearning] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Onlinelearning] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Onlinelearning] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Onlinelearning] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Onlinelearning] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Onlinelearning] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Onlinelearning] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Onlinelearning] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Onlinelearning] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Onlinelearning] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Onlinelearning] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Onlinelearning] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Onlinelearning] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Onlinelearning] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Onlinelearning] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Onlinelearning] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Onlinelearning] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Onlinelearning] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Onlinelearning] SET  MULTI_USER 
GO
ALTER DATABASE [Onlinelearning] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Onlinelearning] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Onlinelearning] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Onlinelearning] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Onlinelearning] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Onlinelearning] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Onlinelearning] SET QUERY_STORE = ON
GO
ALTER DATABASE [Onlinelearning] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Onlinelearning]
GO
/****** Object:  Table [dbo].[category]    Script Date: 4/15/2025 11:21:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[semester] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 4/15/2025 11:21:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teacher_id] [int] NULL,
	[title] [varchar](255) NULL,
	[thumbnail_url] [varchar](255) NULL,
	[description] [text] NULL,
	[category_id] [int] NULL,
	[status] [varchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 4/15/2025 11:21:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 4/15/2025 11:21:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NULL,
	[middle_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[email] [varchar](100) NULL,
	[password] [varchar](255) NULL,
	[role_id] [int] NULL,
	[avatar_url] [varchar](255) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E6164FCBF6170]    Script Date: 4/15/2025 11:21:22 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([id])
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD FOREIGN KEY([teacher_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[category]  WITH CHECK ADD CHECK  (([semester]='kì 9' OR [semester]='kì 8' OR [semester]='kì 7' OR [semester]='kì 6' OR [semester]='kì 5' OR [semester]='kì 4' OR [semester]='kì 3' OR [semester]='kì 2' OR [semester]='kì 1'))
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD CHECK  (([status]='inactive' OR [status]='active'))
GO
USE [master]
GO
ALTER DATABASE [Onlinelearning] SET  READ_WRITE 
GO
