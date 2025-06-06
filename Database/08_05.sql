USE [master]
GO
/****** Object:  Database [Onlinelearning]    Script Date: 5/8/2025 11:07:22 PM ******/
CREATE DATABASE [Onlinelearning]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Onlinelearning', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\Onlinelearning.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Onlinelearning_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\Onlinelearning_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
EXEC sys.sp_db_vardecimal_storage_format N'Onlinelearning', N'ON'
GO
ALTER DATABASE [Onlinelearning] SET QUERY_STORE = ON
GO
ALTER DATABASE [Onlinelearning] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Onlinelearning]
GO
/****** Object:  Table [dbo].[teacher_salary]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teacher_salary](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teacher_id] [int] NOT NULL,
	[gross_amount] [decimal](12, 2) NULL,
	[commission_rate] [decimal](5, 2) NULL,
	[commission_amount] [decimal](12, 2) NULL,
	[total_amount] [decimal](12, 2) NOT NULL,
	[month] [int] NOT NULL,
	[year] [int] NOT NULL,
	[transaction_count] [int] NULL,
	[paid] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[paid_at] [datetime] NULL,
	[notes] [nvarchar](500) NULL,
	[status] [varchar](20) NULL,
	[last_modified_by] [int] NULL,
 CONSTRAINT [PK_teacher_salary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 5/8/2025 11:07:22 PM ******/
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
	[price] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactions]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[course_id] [int] NULL,
	[amount] [decimal](10, 2) NULL,
	[status] [varchar](20) NULL,
	[created_at] [datetime] NULL,
	[revenue_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 5/8/2025 11:07:22 PM ******/
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
	[gender_id] [int] NULL,
	[password] [varchar](255) NULL,
	[role_id] [int] NULL,
	[avatar_url] [varchar](255) NULL,
	[created_at] [datetime] NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TeacherPayrollView]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[TeacherPayrollView]
	AS
	SELECT 
		ts.id AS SalaryID,
		ts.teacher_id AS TeacherID,
		u.first_name + ' ' + COALESCE(u.last_name, '') AS TeacherName,
		ts.gross_amount AS GrossAmount,
		ts.commission_rate AS CommissionRate,
		ts.commission_amount AS CommissionAmount,
		ts.total_amount AS SalaryAmount,
		ts.month AS SalaryMonth,
		ts.year AS SalaryYear,
		CASE ts.paid WHEN 1 THEN 'Paid' ELSE 'Unpaid' END AS PaymentStatus,
		ts.transaction_count AS TransactionCount,
		SUM(t.amount) AS TotalCourseRevenue,
		ts.status AS Status,
		ts.created_at AS CreatedAt,
		ts.paid_at AS PaidAt,
		ts.notes AS Notes,
		ts.last_modified_by AS LastModifiedBy
	FROM [dbo].[teacher_salary] ts
	INNER JOIN [dbo].[users] u ON ts.teacher_id = u.id
	LEFT JOIN [dbo].[courses] c ON u.id = c.teacher_id
	LEFT JOIN [dbo].[transactions] t ON c.id = t.course_id 
		AND t.status = 'paid'
		AND MONTH(t.created_at) = ts.month
		AND YEAR(t.created_at) = ts.year
	WHERE u.role_id = 2
	GROUP BY 
		ts.id, ts.teacher_id, u.first_name, u.last_name, ts.gross_amount, 
		ts.commission_rate, ts.commission_amount, ts.total_amount, 
		ts.month, ts.year, ts.paid, ts.transaction_count, ts.status, 
		ts.created_at, ts.paid_at, ts.notes, ts.last_modified_by;
GO
/****** Object:  View [dbo].[PayrollChartData]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [dbo].[PayrollChartData]
	AS
	SELECT 
		ts.month AS Month,
		ts.year AS Year,
		COUNT(DISTINCT ts.id) AS SalaryCount,
		SUM(ts.total_amount) AS TotalTeacherSalary,
		SUM(ts.gross_amount) AS TotalGrossAmount,
		SUM(ts.commission_amount) AS TotalCommission,
		COUNT(t.id) AS TransactionCount,
		SUM(t.amount) AS TotalRevenue
	FROM [dbo].[teacher_salary] ts
	LEFT JOIN [dbo].[courses] c ON ts.teacher_id = c.teacher_id
	LEFT JOIN [dbo].[transactions] t ON c.id = t.course_id 
		AND t.status = 'paid'
		AND MONTH(t.created_at) = ts.month
		AND YEAR(t.created_at) = ts.year
	GROUP BY ts.month, ts.year;
GO
/****** Object:  View [dbo].[StatisticsView]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StatisticsView]
AS
SELECT 
    YEAR(t.created_at) AS Year, 
    MONTH(t.created_at) AS Month, 
    SUM(t.amount) AS TotalRevenue,
    (SELECT COUNT(DISTINCT id) FROM dbo.users WHERE role_id = 2) AS TotalTeachers,
    (SELECT COUNT(DISTINCT id) FROM dbo.users WHERE role_id = 3) AS TotalStudents, 
    (SELECT COUNT(DISTINCT id) FROM dbo.courses) AS TotalCourses, 
    COUNT(t.id) AS TotalSuccessfulTransactions
FROM 
    dbo.transactions AS t 
    LEFT OUTER JOIN dbo.courses AS c ON t.course_id = c.id
WHERE 
    t.status = 'paid'
GROUP BY 
    YEAR(t.created_at), MONTH(t.created_at);
GO
/****** Object:  View [dbo].[TopTeachersView]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	-- View để lấy top 5 giáo viên có lương cao nhất
	CREATE VIEW [dbo].[TopTeachersView]
	AS
	SELECT TOP 5
		ts.teacher_id AS TeacherID,
		u.first_name + ' ' + u.last_name AS TeacherName,
		SUM(ts.total_amount) AS TotalSalary,
		ts.year AS Year
	FROM [dbo].[teacher_salary] ts
	INNER JOIN [dbo].[users] u ON ts.teacher_id = u.id
	WHERE u.role_id = 2
	GROUP BY ts.teacher_id, u.first_name, u.last_name, ts.year
	ORDER BY SUM(ts.total_amount) DESC;
GO
/****** Object:  Table [dbo].[Answer_Option]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer_Option](
	[OptionID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionID] [int] NOT NULL,
	[Text] [nvarchar](500) NULL,
	[IsCorrect] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[blog_detail]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blog_detail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[blog_id] [int] NOT NULL,
	[detailed_content] [text] NULL,
	[author_bio] [text] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[blogs]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blogs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NULL,
	[content] [text] NULL,
	[author_id] [int] NULL,
	[created_at] [datetime] NULL,
	[thumbnail_url] [nvarchar](500) NULL,
	[published_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[course_id] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 5/8/2025 11:07:22 PM ******/
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
/****** Object:  Table [dbo].[commissions]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[commissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rate] [decimal](5, 2) NULL,
	[effective_from] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course_enrollments]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_enrollments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[course_id] [int] NULL,
	[enrolled_at] [datetime] NULL,
	[status] [varchar](20) NULL,
	[refund_status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feedback]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feedback](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[course_id] [int] NULL,
	[content] [text] NULL,
	[rating] [int] NULL,
	[status] [varchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[genders]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[genders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lesson]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lesson](
	[LessonID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[VideoURL] [nvarchar](500) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lesson_Completion]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lesson_Completion](
	[CompletionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[LessonID] [int] NOT NULL,
	[CompletedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CompletionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_detail]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_detail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[course_id] [int] NULL,
	[quantity] [int] NULL,
	[price] [float] NULL,
 CONSTRAINT [PK_order_detail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[total] [float] NULL,
	[date] [datetime] NULL,
	[status] [varchar](50) NULL,
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payments]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[transaction_id] [int] NULL,
	[payment_method] [varchar](50) NULL,
	[payment_status] [varchar](20) NULL,
	[paid_amount] [decimal](10, 2) NULL,
	[paid_at] [datetime] NULL,
	[user_id] [int] NULL,
	[course_id] [int] NULL,
	[processed_date] [datetime] NULL,
	[processed_by] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[QuizID] [int] NOT NULL,
	[Text] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quiz]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quiz](
	[QuizID] [int] IDENTITY(1,1) NOT NULL,
	[LessonID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[duration_minutes] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[QuizID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quiz_Attempt]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quiz_Attempt](
	[AttemptID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[QuizID] [int] NOT NULL,
	[AttemptDate] [datetime] NULL,
	[Score] [decimal](5, 2) NULL,
	[completion_time_minutes] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AttemptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[refund_requests]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[refund_requests](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[enrollment_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
	[request_date] [datetime] NOT NULL,
	[reason] [nvarchar](max) NULL,
	[status] [nvarchar](50) NULL,
	[processed_date] [datetime] NULL,
	[processed_by] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[revenue]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[revenue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[total_amount] [decimal](15, 2) NOT NULL,
	[commission_id] [int] NULL,
	[commission_rate] [decimal](5, 2) NULL,
	[month] [int] NULL,
	[year] [int] NULL,
	[generated_at] [datetime] NULL,
	[commission_amount]  AS (round(([total_amount]*[commission_rate])/(100.0),(3))) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 5/8/2025 11:07:22 PM ******/
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
/****** Object:  Table [dbo].[subjects]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subjects](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemLogs]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemLogs](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[AdminId] [int] NOT NULL,
	[Action] [nvarchar](100) NOT NULL,
	[TargetType] [nvarchar](100) NOT NULL,
	[TargetId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teacher_requests]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teacher_requests](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[requester_id] [int] NOT NULL,
	[approver_id] [int] NULL,
	[request_date] [datetime] NOT NULL,
	[approve_date] [datetime] NULL,
	[status] [int] NOT NULL,
	[reject_reason] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teacher_subjects]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teacher_subjects](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teacher_id] [int] NULL,
	[subject_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Answer]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Answer](
	[UserAnswerID] [int] IDENTITY(1,1) NOT NULL,
	[AttemptID] [int] NOT NULL,
	[QuestionID] [int] NOT NULL,
	[OptionID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserAnswerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wishlist]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wishlist](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[course_id] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Answer_Option] ON 

INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (1, 1, N'Critical thinking', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (2, 2, N'Stores data', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (3, 3, N'Rate of change', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (4, 4, N'Central processing unit', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (5, 5, N'Step-by-step solution', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (6, 6, N'Class inherits another', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (7, 7, N'Collection of elements', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (8, 8, N'Running program', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (9, 9, N'Routes network traffic', 1)
INSERT [dbo].[Answer_Option] ([OptionID], [QuestionID], [Text], [IsCorrect]) VALUES (10, 10, N'Fully engaged listening', 1)
SET IDENTITY_INSERT [dbo].[Answer_Option] OFF
GO
SET IDENTITY_INSERT [dbo].[blogs] ON 

INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (11, N'The Role of AI in Modern Education', N'Exploring how artificial intelligence reshapes digital classrooms.', 1, CAST(N'2024-11-11T08:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuB-nnL0alDpcbl26La0Zr68Kxl0vAE4ltDw&s', CAST(N'2024-11-11T08:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (12, N'Intro to Machine Learning Algorithms', N'A foundational guide to supervised and unsupervised learning.', 1, CAST(N'2024-11-12T09:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyu7dUbue1BaYIwn79MdhMSg9o2Zcy7HtanQ&s', CAST(N'2024-11-12T09:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (13, N'Protecting Personal Data Online', N'Learn essential practices to keep your information secure.', 5, CAST(N'2024-11-13T10:00:00.000' AS DateTime), N'https://imagedelivery.net/KxWh-mxPGDbsqJB3c5_fmA/1624bfaf-f67c-43ef-87b7-4b03ec503900/public', CAST(N'2024-11-13T10:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (14, N'Emerging Cloud Technologies', N'Discover how cloud services are evolving in 2025.', 5, CAST(N'2024-11-14T11:00:00.000' AS DateTime), N'https://cdn.mysite.com/thumbs/cloud-tech.jpg', CAST(N'2024-11-14T11:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (15, N'Mobile App Development Today', N'A beginner’s roadmap to building effective mobile applications.', 8, CAST(N'2024-11-15T12:00:00.000' AS DateTime), N'https://d2ms8rpfqc4h24.cloudfront.net/feature_image_b35d3377af.jpg', CAST(N'2024-11-15T12:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (16, N'Game Development Using Unity Engine', N'Step-by-step tutorial for developing 2D/3D games in Unity.', 8, CAST(N'2024-11-16T13:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRinfljMnjoLe0zI7bG0EQI73dKqsTDy7HD5Q&s', CAST(N'2024-11-16T13:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (17, N'Leadership in the Workplace', N'Core management strategies for effective leadership.', 21, CAST(N'2024-11-17T14:00:00.000' AS DateTime), N'https://lesley.edu/sites/default/files/styles/image_with_chevron_text_box_paragraph_1x_wide/public/Level-5-Leadership-Hierarchy.png?h=55990620&itok=X58YOJul', CAST(N'2024-11-17T14:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (18, N'Digital Marketing Blueprint', N'Build your brand with cutting-edge marketing techniques.', 21, CAST(N'2024-11-18T15:00:00.000' AS DateTime), N'https://www.marketingeye.com/media/k2/items/cache/828fffe53a98f0c1514968a7bec47b66_XL.jpg', CAST(N'2024-11-18T15:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (19, N'Intro to Human Psychology', N'Understand core concepts of human thought and emotion.', 30, CAST(N'2024-11-19T16:00:00.000' AS DateTime), N'https://imotions.com/wp-content/uploads/2024/04/Foundations-of-human-behavior.webp', CAST(N'2024-11-19T16:30:00.000' AS DateTime))
INSERT [dbo].[blogs] ([id], [title], [content], [author_id], [created_at], [thumbnail_url], [published_at]) VALUES (20, N'World History Insights', N'Reviewing pivotal events and their global impact.', 30, CAST(N'2024-11-20T17:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEKlSD3ZBCwSNY-39xgxRNIMmEqrWy9y8oAQ&s', CAST(N'2024-11-20T17:30:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[blogs] OFF
GO
SET IDENTITY_INSERT [dbo].[cart] ON 

INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (1, 22, 11, CAST(N'2024-11-11T08:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (2, 23, 12, CAST(N'2024-11-12T09:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (3, 24, 13, CAST(N'2024-11-13T10:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (4, 25, 14, CAST(N'2024-11-14T11:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (5, 26, 15, CAST(N'2024-11-15T12:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (6, 27, 16, CAST(N'2024-11-16T13:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (7, 28, 17, CAST(N'2024-11-17T14:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (8, 29, 18, CAST(N'2024-11-18T15:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (9, 22, 19, CAST(N'2024-11-19T16:00:00.000' AS DateTime))
INSERT [dbo].[cart] ([id], [student_id], [course_id], [created_at]) VALUES (10, 23, 20, CAST(N'2024-11-20T17:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([id], [semester]) VALUES (1, N'semester 1')
INSERT [dbo].[category] ([id], [semester]) VALUES (2, N'semester 2')
INSERT [dbo].[category] ([id], [semester]) VALUES (3, N'semester 3')
INSERT [dbo].[category] ([id], [semester]) VALUES (4, N'semester 4')
INSERT [dbo].[category] ([id], [semester]) VALUES (5, N'semester 5')
INSERT [dbo].[category] ([id], [semester]) VALUES (6, N'semester 6')
INSERT [dbo].[category] ([id], [semester]) VALUES (7, N'semester 7')
INSERT [dbo].[category] ([id], [semester]) VALUES (8, N'semester 8')
INSERT [dbo].[category] ([id], [semester]) VALUES (9, N'semester 9')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[commissions] ON 

INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (1, CAST(20.00 AS Decimal(5, 2)), CAST(N'2024-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (2, CAST(22.00 AS Decimal(5, 2)), CAST(N'2024-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (3, CAST(24.00 AS Decimal(5, 2)), CAST(N'2024-03-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (4, CAST(25.00 AS Decimal(5, 2)), CAST(N'2024-04-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (5, CAST(20.00 AS Decimal(5, 2)), CAST(N'2024-05-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (6, CAST(21.00 AS Decimal(5, 2)), CAST(N'2024-06-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (7, CAST(23.00 AS Decimal(5, 2)), CAST(N'2024-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (8, CAST(24.00 AS Decimal(5, 2)), CAST(N'2024-08-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (9, CAST(22.00 AS Decimal(5, 2)), CAST(N'2024-09-01T00:00:00.000' AS DateTime))
INSERT [dbo].[commissions] ([id], [rate], [effective_from]) VALUES (10, CAST(20.00 AS Decimal(5, 2)), CAST(N'2024-10-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[commissions] OFF
GO
SET IDENTITY_INSERT [dbo].[course_enrollments] ON 

INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (12, 2, 1, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'quit', N'refunded')
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (13, 3, 5, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'studying', NULL)
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (14, 6, 10, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'studying', NULL)
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (15, 7, 15, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'studying', NULL)
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (16, 9, 20, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'studying', NULL)
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (17, 12, 25, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'studying', NULL)
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (18, 13, 30, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'studying', NULL)
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (19, 2, 35, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'quit', N'refunded')
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (20, 3, 40, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'studying', NULL)
INSERT [dbo].[course_enrollments] ([id], [student_id], [course_id], [enrolled_at], [status], [refund_status]) VALUES (21, 6, 42, CAST(N'2025-05-03T18:51:16.870' AS DateTime), N'studying', NULL)
SET IDENTITY_INSERT [dbo].[course_enrollments] OFF
GO
SET IDENTITY_INSERT [dbo].[courses] ON 

INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (1, 5, N'Academic Skills for University Success', N'https://tinylink.info/112B0', N'Learn Academic Skills for University Success.', 1, N'inactive', CAST(N'2024-10-11T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (2, 30, N'Programming Fundamentals', N'https://tinylink.info/112B9', N'Learn Programming Fundamentals.', 1, N'active', CAST(N'2024-10-12T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (3, 1, N'Mathematics for Engineering', N'https://shorturl.at/v3Par', N'Learn Mathematics for Engineering.', 1, N'active', CAST(N'2024-10-13T09:00:00.000' AS DateTime), CAST(79.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (4, 21, N'Computer Organization and Architecture', N'https://shorturl.at/rlx1k', N'Learn Computer Organization and Architecture.', 1, N'active', CAST(N'2024-10-14T09:00:00.000' AS DateTime), CAST(69.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (5, 8, N'Introduction to Computer Science', N'https://shorturl.at/ogZar', N'Learn Introduction to Computer Science.', 1, N'active', CAST(N'2024-10-15T09:00:00.000' AS DateTime), CAST(54.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (6, 8, N'Object-Oriented Programming', N'https://tinyurl.com/yn5cv42x', N'Learn Object-Oriented Programming.', 2, N'active', CAST(N'2024-10-16T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (7, 30, N'Discrete mathematics', N'https://tinyurl.com/34bthytf', N'Learn Discrete mathematics.', 2, N'active', CAST(N'2024-10-17T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (8, 1, N'Operating Systems', N'https://tinyurl.com/2s3r2266', N'Learn Operating Systems.', 2, N'active', CAST(N'2024-10-18T09:00:00.000' AS DateTime), CAST(69.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (9, 5, N'Computer Networking', N'https://tinyurl.com/4r8v2jh2', N'Learn Computer Networking.', 2, N'active', CAST(N'2024-10-19T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (10, 5, N'Communication and In-Group Working Skills', N'https://tinyurl.com/3zthdv9e', N'Learn Communication and In-Group Working Skills.', 2, N'active', CAST(N'2024-10-20T09:00:00.000' AS DateTime), CAST(54.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (11, 21, N'Elementary Japanese 1-A1.1', N'https://tinyurl.com/33dbsvh3', N'Learn Elementary Japanese 1-A1.1.', 3, N'active', CAST(N'2024-10-21T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (12, 8, N'Data Structures and Algorithms', N'https://tinyurl.com/5yrjmj66', N'Learn Data Structures and Algorithms.', 3, N'active', CAST(N'2024-10-22T09:00:00.000' AS DateTime), CAST(79.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (13, 5, N'Introduction to Databases', N'https://tinyurl.com/yw7xufy3', N'Learn Introduction to Databases.', 3, N'active', CAST(N'2024-10-23T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (14, 30, N'OOP with Java Lab', N'https://tinyurl.com/2pank6a2', N'Learn OOP with Java Lab.', 3, N'active', CAST(N'2024-10-24T09:00:00.000' AS DateTime), CAST(69.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (15, 21, N'Web Design', N'https://tinyurl.com/shew3mt9', N'Learn Web Design.', 3, N'active', CAST(N'2024-10-25T09:00:00.000' AS DateTime), CAST(54.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (16, 1, N'Statistics and Probability', N'https://tinyurl.com/5c433u67', N'Learn Statistics and Probability.', 4, N'active', CAST(N'2024-10-26T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (17, 8, N'Elementary Japanese 1-A1.2', N'https://tinyurl.com/4sb8dv4u', N'Learn Elementary Japanese 1-A1.2.', 4, N'active', CAST(N'2024-10-27T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (18, 30, N'Internet All Thing', N'https://tinyurl.com/3yw4tr6y', N'Learn Internet van vat.', 4, N'active', CAST(N'2024-10-28T09:00:00.000' AS DateTime), CAST(64.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (19, 30, N'Java Web Application Development', N'https://tinyurl.com/3merxw2h', N'Learn Java Web Application Development.', 4, N'active', CAST(N'2024-10-29T09:00:00.000' AS DateTime), CAST(69.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (20, 1, N'Introduction to Software Engineering', N'https://tinyurl.com/5n89n7hm', N'Learn Introduction to Software Engineering.', 4, N'active', CAST(N'2024-10-30T09:00:00.000' AS DateTime), CAST(54.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (21, 5, N'Application development project', N'https://tinyurl.com/3t4ezkss', N'Learn Application development project.', 5, N'active', CAST(N'2024-10-31T09:00:00.000' AS DateTime), CAST(79.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (22, 21, N'Ethics in IT', N'https://tinyurl.com/eh8wvz9u', N'Learn Ethics in IT.', 5, N'active', CAST(N'2024-11-01T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (23, 1, N'Software Requirement', N'https://tinyurl.com/2s492nhm', N'Learn Software Requirement.', 5, N'active', CAST(N'2024-11-02T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (24, 5, N'Software Testing', N'https://tinyurl.com/ybtfh66s', N'Learn Software Testing.', 5, N'active', CAST(N'2024-11-03T09:00:00.000' AS DateTime), CAST(69.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (25, 8, N'Basic Cross-Platform Application Programming With .NET', N'https://tinyurl.com/3su6nkuw', N'Learn Basic Cross-Platform Application Programming With .NET.', 5, N'active', CAST(N'2024-11-04T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (26, 21, N'On the job training', N'https://tinyurl.com/yvt7ram8', N'Learn On the job training.', 6, N'active', CAST(N'2024-11-05T09:00:00.000' AS DateTime), CAST(54.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (27, 30, N'Writing Research Papers', N'https://tinyurl.com/5hchp723', N'Learn Writing Research Papers.', 6, N'active', CAST(N'2024-11-06T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (28, 1, N'Advanced Cross-Platform Application Programming With .NET', N'https://tinyurl.com/ybtfh66s', N'Learn Advanced Cross-Platform Application Programming With .NET.', 7, N'active', CAST(N'2024-11-07T09:00:00.000' AS DateTime), CAST(79.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (29, 5, N'Experiential Entrepreneurship1', N'https://tinyurl.com/tmcznds4', N'Learn Experiential Entrepreneurship1.', 7, N'active', CAST(N'2024-11-08T09:00:00.000' AS DateTime), CAST(69.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (30, 8, N'Mobile Programming', N'https://tinyurl.com/zkrxn8m3', N'Learn Mobile Programming.', 7, N'active', CAST(N'2024-11-09T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (31, 30, N'C# Programming and Unity', N'https://tinyurl.com/5jaxrfrf', N'Learn C# Programming and Unity.', 7, N'active', CAST(N'2024-11-10T09:00:00.000' AS DateTime), CAST(54.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (32, 8, N'SW Architecture and Design', N'https://tinyurl.com/38sm9e8y', N'Learn SW Architecture and Design.', 7, N'active', CAST(N'2024-11-11T09:00:00.000' AS DateTime), CAST(64.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (33, 5, N'Experiential Entrepreneurship 2', N'https://tinyurl.com/tmcznds4', N'Learn Experiential Entrepreneurship 2.', 8, N'active', CAST(N'2024-11-12T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (34, 21, N'Political economics of Marxism – Leninism', N'https://tinyurl.com/mryyyyed', N'Learn Political economics of Marxism – Leninism.', 8, N'active', CAST(N'2024-11-13T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (35, 8, N'UI/UX Design', N'https://tinyurl.com/3dytuhuy', N'Learn UI/UX Design.', 8, N'active', CAST(N'2024-11-14T09:00:00.000' AS DateTime), CAST(69.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (36, 1, N'Building Cross-Platform Back-End Application With .NET', N'https://tinyurl.com/4dvjj556', N'Learn Building Cross-Platform Back-End Application With .NET.', 8, N'active', CAST(N'2024-11-15T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (37, 30, N'Project management', N'https://tinyurl.com/mrs7bun4', N'Learn Project management.', 8, N'active', CAST(N'2024-11-16T09:00:00.000' AS DateTime), CAST(54.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (38, 21, N'Philosophy of Marxism – Leninism', N'https://tinyurl.com/yts9cj7s', N'Learn Philosophy of Marxism – Leninism.', 8, N'active', CAST(N'2024-11-17T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (39, 5, N'Scientific socialism', N'https://tinyurl.com/2hu5zjwc', N'Learn Scientific socialism.', 9, N'active', CAST(N'2024-11-18T09:00:00.000' AS DateTime), CAST(59.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (40, 8, N'History of Viet Nam Communist Party', N'https://tinyurl.com/5ysm8yeh', N'Learn History of Vi?t Nam Communist Party.', 9, N'active', CAST(N'2024-11-19T09:00:00.000' AS DateTime), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (41, 1, N'SE Capstone Project', N'https://tinyurl.com/43a8342f', N'Learn SE Capstone Project.', 9, N'active', CAST(N'2024-11-20T09:00:00.000' AS DateTime), CAST(79.99 AS Decimal(10, 2)))
INSERT [dbo].[courses] ([id], [teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) VALUES (42, 30, N'Ho Chi Minh Ideology', N'https://tinyurl.com/3csu2kxu', N'Learn Ho Chi Minh Ideology.', 9, N'active', CAST(N'2024-11-21T09:00:00.000' AS DateTime), CAST(69.99 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[courses] OFF
GO
SET IDENTITY_INSERT [dbo].[feedback] ON 

INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (1, 22, 31, N'Excellent course content!', 5, N'visible', CAST(N'2024-11-11T08:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (2, 23, 32, N'Very informative, well-structured.', 4, N'visible', CAST(N'2024-11-12T09:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (3, 24, 33, N'Great teacher, engaging lessons.', 5, N'visible', CAST(N'2024-11-13T10:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (4, 25, 34, N'Could use more practical examples.', 3, N'visible', CAST(N'2024-11-14T11:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (5, 26, 35, N'Loved the course!', 5, N'visible', CAST(N'2024-11-15T12:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (6, 27, 36, N'Good but pacing was fast.', 4, N'visible', CAST(N'2024-11-16T13:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (7, 28, 37, N'Needs more interactive content.', 3, N'visible', CAST(N'2024-11-17T14:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (8, 29, 38, N'Highly recommend this course!', 5, N'visible', CAST(N'2024-11-18T15:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (9, 22, 39, N'Solid course, good value.', 4, N'visible', CAST(N'2024-11-19T16:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (10, 23, 40, N'Fantastic learning experience!', 5, N'visible', CAST(N'2024-11-20T17:00:00.000' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (11, 3, 2, N'a', 5, N'Visible', CAST(N'2025-05-06T00:23:04.837' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (12, 3, 2, N'a', 1, N'Visible', CAST(N'2025-05-06T01:16:44.797' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (13, 2, 2, N'a', 5, N'Visible', CAST(N'2025-05-06T01:20:42.707' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (14, 2, 2, N'4', 1, N'Visible', CAST(N'2025-05-06T03:26:54.197' AS DateTime))
INSERT [dbo].[feedback] ([id], [student_id], [course_id], [content], [rating], [status], [created_at]) VALUES (15, 2, 2, N'a', 1, N'Visible', CAST(N'2025-05-06T04:18:43.087' AS DateTime))
SET IDENTITY_INSERT [dbo].[feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[genders] ON 

INSERT [dbo].[genders] ([id], [name]) VALUES (1, N'Male')
INSERT [dbo].[genders] ([id], [name]) VALUES (2, N'Female')
INSERT [dbo].[genders] ([id], [name]) VALUES (3, N'Other')
SET IDENTITY_INSERT [dbo].[genders] OFF
GO
SET IDENTITY_INSERT [dbo].[Lesson] ON 

INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (1, 1, N'Academic Skills Intro', N'Introduction to academic skills...', N'https://example.com/video1.mp4', CAST(N'2024-11-11T08:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (2, 2, N'Programming Basics', N'Learn programming fundamentals...', N'https://example.com/video2.mp4', CAST(N'2024-11-12T09:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (3, 3, N'Engineering Math Intro', N'Basics of engineering math...', N'https://example.com/video3.mp4', CAST(N'2024-11-13T10:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (4, 4, N'Computer Architecture', N'Understanding computer organization...', N'https://example.com/video4.mp4', CAST(N'2024-11-14T11:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (5, 5, N'CS Fundamentals', N'Introduction to computer science...', N'https://example.com/video5.mp4', CAST(N'2024-11-15T12:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (6, 6, N'OOP Concepts', N'Learn object-oriented programming...', N'https://example.com/video6.mp4', CAST(N'2024-11-16T13:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (7, 7, N'Discrete Math Intro', N'Basics of discrete mathematics...', N'https://example.com/video7.mp4', CAST(N'2024-11-17T14:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (8, 8, N'OS Fundamentals', N'Introduction to operating systems...', N'https://example.com/video8.mp4', CAST(N'2024-11-18T15:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (9, 9, N'Networking Basics', N'Learn computer networking...', N'https://example.com/video9.mp4', CAST(N'2024-11-19T16:00:00.000' AS DateTime))
INSERT [dbo].[Lesson] ([LessonID], [CourseID], [Title], [Content], [VideoURL], [CreatedAt]) VALUES (10, 10, N'Group Communication', N'Effective in-group communication...', N'https://example.com/video10.mp4', CAST(N'2024-11-20T17:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Lesson] OFF
GO
SET IDENTITY_INSERT [dbo].[Lesson_Completion] ON 

INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (1, 22, 1, CAST(N'2024-11-11T08:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (2, 23, 2, CAST(N'2024-11-12T09:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (3, 24, 3, CAST(N'2024-11-13T10:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (4, 25, 4, CAST(N'2024-11-14T11:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (5, 26, 5, CAST(N'2024-11-15T12:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (6, 27, 6, CAST(N'2024-11-16T13:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (7, 28, 7, CAST(N'2024-11-17T14:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (8, 29, 8, CAST(N'2024-11-18T15:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (9, 22, 9, CAST(N'2024-11-19T16:30:00.000' AS DateTime))
INSERT [dbo].[Lesson_Completion] ([CompletionID], [UserID], [LessonID], [CompletedAt]) VALUES (10, 23, 10, CAST(N'2024-11-20T17:30:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Lesson_Completion] OFF
GO
SET IDENTITY_INSERT [dbo].[order_detail] ON 

INSERT [dbo].[order_detail] ([id], [order_id], [course_id], [quantity], [price]) VALUES (1, 1, 3, 1, 79)
INSERT [dbo].[order_detail] ([id], [order_id], [course_id], [quantity], [price]) VALUES (2, 2, 4, 1, 69)
INSERT [dbo].[order_detail] ([id], [order_id], [course_id], [quantity], [price]) VALUES (3, 3, 6, 1, 59)
INSERT [dbo].[order_detail] ([id], [order_id], [course_id], [quantity], [price]) VALUES (4, 3, 5, 1, 54)
INSERT [dbo].[order_detail] ([id], [order_id], [course_id], [quantity], [price]) VALUES (5, 4, 6, 1, 59)
INSERT [dbo].[order_detail] ([id], [order_id], [course_id], [quantity], [price]) VALUES (6, 4, 7, 1, 49)
INSERT [dbo].[order_detail] ([id], [order_id], [course_id], [quantity], [price]) VALUES (7, 4, 9, 1, 59)
INSERT [dbo].[order_detail] ([id], [order_id], [course_id], [quantity], [price]) VALUES (8, 5, 8, 1, 69)
SET IDENTITY_INSERT [dbo].[order_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [user_id], [total], [date], [status]) VALUES (1, 2, 79, CAST(N'2025-05-08T21:23:07.530' AS DateTime), N'Confirmed')
INSERT [dbo].[orders] ([id], [user_id], [total], [date], [status]) VALUES (2, 2, 69, CAST(N'2025-05-08T22:40:52.790' AS DateTime), N'Pending')
INSERT [dbo].[orders] ([id], [user_id], [total], [date], [status]) VALUES (3, 2, 113, CAST(N'2025-05-08T22:43:14.457' AS DateTime), N'Confirmed')
INSERT [dbo].[orders] ([id], [user_id], [total], [date], [status]) VALUES (4, 2, 167, CAST(N'2025-05-08T22:58:28.520' AS DateTime), N'Pending')
INSERT [dbo].[orders] ([id], [user_id], [total], [date], [status]) VALUES (5, 2, 69, CAST(N'2025-05-08T23:01:29.863' AS DateTime), N'Pending')
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[payments] ON 

INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (1, 1, N'Credit Card', N'success', CAST(49.99 AS Decimal(10, 2)), CAST(N'2024-11-11T08:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (2, 2, N'PayPal', N'success', CAST(59.99 AS Decimal(10, 2)), CAST(N'2024-11-12T09:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (3, 3, N'Bank Transfer', N'success', CAST(79.99 AS Decimal(10, 2)), CAST(N'2024-11-13T10:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (4, 4, N'Credit Card', N'success', CAST(69.99 AS Decimal(10, 2)), CAST(N'2024-11-14T11:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (5, 5, N'PayPal', N'success', CAST(54.99 AS Decimal(10, 2)), CAST(N'2024-11-15T12:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (6, 6, N'Credit Card', N'success', CAST(59.99 AS Decimal(10, 2)), CAST(N'2024-11-16T13:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (7, 7, N'Bank Transfer', N'success', CAST(49.99 AS Decimal(10, 2)), CAST(N'2024-11-17T14:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (8, 8, N'PayPal', N'success', CAST(69.99 AS Decimal(10, 2)), CAST(N'2024-11-18T15:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (9, 9, N'Credit Card', N'success', CAST(59.99 AS Decimal(10, 2)), CAST(N'2024-11-19T16:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (10, 10, N'Bank Transfer', N'success', CAST(54.99 AS Decimal(10, 2)), CAST(N'2024-11-20T17:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (11, 11, N'Credit Card', N'success', CAST(49.99 AS Decimal(10, 2)), CAST(N'2024-11-11T08:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (12, 12, N'PayPal', N'success', CAST(79.99 AS Decimal(10, 2)), CAST(N'2024-11-12T09:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (13, 13, N'Bank Transfer', N'success', CAST(59.99 AS Decimal(10, 2)), CAST(N'2024-11-13T10:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (14, 14, N'Credit Card', N'success', CAST(69.99 AS Decimal(10, 2)), CAST(N'2024-11-14T11:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (15, 15, N'PayPal', N'success', CAST(54.99 AS Decimal(10, 2)), CAST(N'2024-11-15T12:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (16, 16, N'Credit Card', N'success', CAST(59.99 AS Decimal(10, 2)), CAST(N'2024-11-16T13:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (17, 17, N'Bank Transfer', N'success', CAST(49.99 AS Decimal(10, 2)), CAST(N'2024-11-17T14:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (18, 18, N'PayPal', N'success', CAST(64.99 AS Decimal(10, 2)), CAST(N'2024-11-18T15:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (19, 19, N'Credit Card', N'success', CAST(69.99 AS Decimal(10, 2)), CAST(N'2024-11-19T16:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[payments] ([id], [transaction_id], [payment_method], [payment_status], [paid_amount], [paid_at], [user_id], [course_id], [processed_date], [processed_by]) VALUES (20, 20, N'Bank Transfer', N'success', CAST(54.99 AS Decimal(10, 2)), CAST(N'2024-11-20T17:10:00.000' AS DateTime), NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (1, 1, N'What is an academic skill?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (2, 2, N'What is a variable in programming?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (3, 3, N'What is a derivative?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (4, 4, N'What is a CPU?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (5, 5, N'What is an algorithm?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (6, 6, N'What is inheritance?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (7, 7, N'What is a set in math?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (8, 8, N'What is a process in OS?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (9, 9, N'What is a router?')
INSERT [dbo].[Question] ([QuestionID], [QuizID], [Text]) VALUES (10, 10, N'What is active listening?')
SET IDENTITY_INSERT [dbo].[Question] OFF
GO
SET IDENTITY_INSERT [dbo].[Quiz] ON 

INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (1, 1, N'Academic Skills Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (2, 2, N'Programming Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (3, 3, N'Engineering Math Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (4, 4, N'Architecture Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (5, 5, N'CS Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (6, 6, N'OOP Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (7, 7, N'Discrete Math Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (8, 8, N'OS Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (9, 9, N'Networking Quiz', 30)
INSERT [dbo].[Quiz] ([QuizID], [LessonID], [Title], [duration_minutes]) VALUES (10, 10, N'Communication Quiz', 30)
SET IDENTITY_INSERT [dbo].[Quiz] OFF
GO
SET IDENTITY_INSERT [dbo].[Quiz_Attempt] ON 

INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (1, 22, 1, CAST(N'2024-11-11T09:00:00.000' AS DateTime), CAST(92.00 AS Decimal(5, 2)), 25)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (2, 23, 2, CAST(N'2024-11-12T10:00:00.000' AS DateTime), CAST(88.00 AS Decimal(5, 2)), 28)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (3, 24, 3, CAST(N'2024-11-13T11:00:00.000' AS DateTime), CAST(95.00 AS Decimal(5, 2)), 20)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (4, 25, 4, CAST(N'2024-11-14T12:00:00.000' AS DateTime), CAST(80.00 AS Decimal(5, 2)), 30)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (5, 26, 5, CAST(N'2024-11-15T13:00:00.000' AS DateTime), CAST(90.00 AS Decimal(5, 2)), 27)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (6, 27, 6, CAST(N'2024-11-16T14:00:00.000' AS DateTime), CAST(85.00 AS Decimal(5, 2)), 22)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (7, 28, 7, CAST(N'2024-11-17T15:00:00.000' AS DateTime), CAST(78.00 AS Decimal(5, 2)), 29)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (8, 29, 8, CAST(N'2024-11-18T16:00:00.000' AS DateTime), CAST(92.00 AS Decimal(5, 2)), 24)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (9, 22, 9, CAST(N'2024-11-19T17:00:00.000' AS DateTime), CAST(88.00 AS Decimal(5, 2)), 26)
INSERT [dbo].[Quiz_Attempt] ([AttemptID], [UserID], [QuizID], [AttemptDate], [Score], [completion_time_minutes]) VALUES (10, 23, 10, CAST(N'2024-11-20T18:00:00.000' AS DateTime), CAST(90.00 AS Decimal(5, 2)), 21)
SET IDENTITY_INSERT [dbo].[Quiz_Attempt] OFF
GO
SET IDENTITY_INSERT [dbo].[refund_requests] ON 

INSERT [dbo].[refund_requests] ([id], [enrollment_id], [student_id], [course_id], [request_date], [reason], [status], [processed_date], [processed_by]) VALUES (16, 12, 2, 1, CAST(N'2025-05-03T19:55:55.900' AS DateTime), N'QUIT', N'approved', CAST(N'2025-05-03T19:56:10.997' AS DateTime), 4)
INSERT [dbo].[refund_requests] ([id], [enrollment_id], [student_id], [course_id], [request_date], [reason], [status], [processed_date], [processed_by]) VALUES (19, 19, 2, 35, CAST(N'2025-05-03T20:01:30.780' AS DateTime), N'quit', N'approved', CAST(N'2025-05-08T18:42:21.930' AS DateTime), 4)
SET IDENTITY_INSERT [dbo].[refund_requests] OFF
GO
SET IDENTITY_INSERT [dbo].[revenue] ON 

INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (1, CAST(649.90 AS Decimal(15, 2)), 1, CAST(20.00 AS Decimal(5, 2)), 1, 2024, CAST(N'2024-01-31T08:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (2, CAST(799.90 AS Decimal(15, 2)), 2, CAST(22.00 AS Decimal(5, 2)), 2, 2024, CAST(N'2024-02-28T09:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (3, CAST(599.90 AS Decimal(15, 2)), 3, CAST(24.00 AS Decimal(5, 2)), 3, 2024, CAST(N'2024-03-31T10:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (4, CAST(549.90 AS Decimal(15, 2)), 4, CAST(25.00 AS Decimal(5, 2)), 4, 2024, CAST(N'2024-04-30T11:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (5, CAST(699.90 AS Decimal(15, 2)), 5, CAST(20.00 AS Decimal(5, 2)), 5, 2024, CAST(N'2024-05-31T12:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (6, CAST(499.90 AS Decimal(15, 2)), 6, CAST(21.00 AS Decimal(5, 2)), 6, 2024, CAST(N'2024-06-30T13:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (7, CAST(899.90 AS Decimal(15, 2)), 7, CAST(23.00 AS Decimal(5, 2)), 7, 2024, CAST(N'2024-07-31T14:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (8, CAST(749.90 AS Decimal(15, 2)), 8, CAST(24.00 AS Decimal(5, 2)), 8, 2024, CAST(N'2024-08-31T15:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (9, CAST(449.90 AS Decimal(15, 2)), 9, CAST(22.00 AS Decimal(5, 2)), 9, 2024, CAST(N'2024-09-30T16:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (10, CAST(649.90 AS Decimal(15, 2)), 10, CAST(20.00 AS Decimal(5, 2)), 10, 2024, CAST(N'2024-10-31T17:00:00.000' AS DateTime))
INSERT [dbo].[revenue] ([id], [total_amount], [commission_id], [commission_rate], [month], [year], [generated_at]) VALUES (11, CAST(1224.80 AS Decimal(15, 2)), 10, CAST(20.00 AS Decimal(5, 2)), 11, 2024, CAST(N'2025-05-03T22:29:12.017' AS DateTime))
SET IDENTITY_INSERT [dbo].[revenue] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [name]) VALUES (1, N'Admin')
INSERT [dbo].[roles] ([id], [name]) VALUES (2, N'Teacher')
INSERT [dbo].[roles] ([id], [name]) VALUES (3, N'Student')
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[subjects] ON 

INSERT [dbo].[subjects] ([id], [name]) VALUES (1, N'Artificial Intelligence')
INSERT [dbo].[subjects] ([id], [name]) VALUES (2, N'Machine Learning')
INSERT [dbo].[subjects] ([id], [name]) VALUES (3, N'Cybersecurity')
INSERT [dbo].[subjects] ([id], [name]) VALUES (4, N'Cloud Computing')
INSERT [dbo].[subjects] ([id], [name]) VALUES (5, N'Mobile Development')
INSERT [dbo].[subjects] ([id], [name]) VALUES (6, N'Game Development')
INSERT [dbo].[subjects] ([id], [name]) VALUES (7, N'Business Management')
INSERT [dbo].[subjects] ([id], [name]) VALUES (8, N'Marketing')
INSERT [dbo].[subjects] ([id], [name]) VALUES (9, N'Psychology')
INSERT [dbo].[subjects] ([id], [name]) VALUES (10, N'History')
SET IDENTITY_INSERT [dbo].[subjects] OFF
GO
SET IDENTITY_INSERT [dbo].[teacher_salary] ON 

INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (1, 1, CAST(159.98 AS Decimal(12, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(31.99 AS Decimal(12, 2)), CAST(127.99 AS Decimal(12, 2)), 1, 2024, 2, 1, CAST(N'2024-01-31T08:00:00.000' AS DateTime), CAST(N'2024-01-31T08:30:00.000' AS DateTime), N'Paid on time', N'Paid', 4)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (2, 5, CAST(129.98 AS Decimal(12, 2)), CAST(22.00 AS Decimal(5, 2)), CAST(28.60 AS Decimal(12, 2)), CAST(101.38 AS Decimal(12, 2)), 2, 2024, 2, 1, CAST(N'2024-02-28T09:00:00.000' AS DateTime), NULL, N'Pending payment', N'Paid', NULL)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (3, 8, CAST(169.98 AS Decimal(12, 2)), CAST(24.00 AS Decimal(5, 2)), CAST(40.80 AS Decimal(12, 2)), CAST(129.18 AS Decimal(12, 2)), 3, 2024, 2, 1, CAST(N'2024-03-31T10:00:00.000' AS DateTime), CAST(N'2024-03-31T10:30:00.000' AS DateTime), NULL, N'Paid', 4)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (4, 21, CAST(149.98 AS Decimal(12, 2)), CAST(25.00 AS Decimal(5, 2)), CAST(37.50 AS Decimal(12, 2)), CAST(112.48 AS Decimal(12, 2)), 4, 2024, 2, 1, CAST(N'2024-04-30T11:00:00.000' AS DateTime), NULL, N'Awaiting approval', N'Paid', NULL)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (5, 30, CAST(119.98 AS Decimal(12, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(24.00 AS Decimal(12, 2)), CAST(95.98 AS Decimal(12, 2)), 5, 2024, 2, 1, CAST(N'2024-05-31T12:00:00.000' AS DateTime), NULL, N'Under review', N'Paid', NULL)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (6, 1, CAST(139.98 AS Decimal(12, 2)), CAST(21.00 AS Decimal(5, 2)), CAST(29.40 AS Decimal(12, 2)), CAST(110.58 AS Decimal(12, 2)), 6, 2024, 2, 1, CAST(N'2024-06-30T13:00:00.000' AS DateTime), CAST(N'2024-06-30T13:30:00.000' AS DateTime), NULL, N'Paid', 4)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (7, 5, CAST(189.98 AS Decimal(12, 2)), CAST(23.00 AS Decimal(5, 2)), CAST(43.70 AS Decimal(12, 2)), CAST(146.28 AS Decimal(12, 2)), 7, 2024, 2, 1, CAST(N'2024-07-31T14:00:00.000' AS DateTime), CAST(N'2024-07-31T14:30:00.000' AS DateTime), N'Processed', N'Paid', 4)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (8, 8, CAST(159.98 AS Decimal(12, 2)), CAST(0.23 AS Decimal(5, 2)), CAST(36.80 AS Decimal(12, 2)), CAST(123.18 AS Decimal(12, 2)), 8, 2024, 2, 0, CAST(N'2024-08-31T15:00:00.000' AS DateTime), NULL, N'Pending payment', N'Pending', 4)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (9, 21, CAST(99.98 AS Decimal(12, 2)), CAST(0.23 AS Decimal(5, 2)), CAST(23.00 AS Decimal(12, 2)), CAST(76.98 AS Decimal(12, 2)), 9, 2024, 2, 0, CAST(N'2024-09-30T16:00:00.000' AS DateTime), NULL, N'Under review', N'Pending', 4)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (10, 30, CAST(89.98 AS Decimal(12, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(18.00 AS Decimal(12, 2)), CAST(71.98 AS Decimal(12, 2)), 10, 2024, 2, 1, CAST(N'2024-10-31T17:00:00.000' AS DateTime), CAST(N'2024-10-31T17:30:00.000' AS DateTime), NULL, N'Paid', 4)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (11, 1, CAST(264.96 AS Decimal(12, 2)), CAST(0.21 AS Decimal(5, 2)), CAST(55.64 AS Decimal(12, 2)), CAST(209.32 AS Decimal(12, 2)), 11, 2024, 4, 0, CAST(N'2025-04-28T14:47:41.233' AS DateTime), NULL, NULL, N'Pending', 4)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (12, 5, CAST(224.96 AS Decimal(12, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(44.99 AS Decimal(12, 2)), CAST(179.97 AS Decimal(12, 2)), 11, 2024, 4, 0, CAST(N'2025-04-28T14:47:41.233' AS DateTime), NULL, NULL, N'Pending', NULL)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (13, 8, CAST(244.96 AS Decimal(12, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(48.99 AS Decimal(12, 2)), CAST(195.97 AS Decimal(12, 2)), 11, 2024, 4, 0, CAST(N'2025-04-28T14:47:41.233' AS DateTime), NULL, NULL, N'Pending', NULL)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (14, 21, CAST(174.97 AS Decimal(12, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(34.99 AS Decimal(12, 2)), CAST(139.98 AS Decimal(12, 2)), 11, 2024, 3, 0, CAST(N'2025-04-28T14:47:41.233' AS DateTime), NULL, NULL, N'Pending', NULL)
INSERT [dbo].[teacher_salary] ([id], [teacher_id], [gross_amount], [commission_rate], [commission_amount], [total_amount], [month], [year], [transaction_count], [paid], [created_at], [paid_at], [notes], [status], [last_modified_by]) VALUES (15, 30, CAST(314.95 AS Decimal(12, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(62.99 AS Decimal(12, 2)), CAST(251.96 AS Decimal(12, 2)), 11, 2024, 5, 0, CAST(N'2025-04-28T14:47:41.233' AS DateTime), NULL, NULL, N'Pending', NULL)
SET IDENTITY_INSERT [dbo].[teacher_salary] OFF
GO
SET IDENTITY_INSERT [dbo].[teacher_subjects] ON 

INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (1, 1, 1)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (2, 1, 2)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (3, 5, 3)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (4, 5, 4)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (5, 8, 5)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (6, 8, 6)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (7, 21, 7)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (8, 21, 8)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (9, 30, 9)
INSERT [dbo].[teacher_subjects] ([id], [teacher_id], [subject_id]) VALUES (10, 30, 10)
SET IDENTITY_INSERT [dbo].[teacher_subjects] OFF
GO
SET IDENTITY_INSERT [dbo].[transactions] ON 

INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (1, 22, 1, CAST(49.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-11T08:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (2, 23, 2, CAST(59.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-12T09:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (3, 24, 3, CAST(79.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-13T10:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (4, 25, 4, CAST(69.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-14T11:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (5, 26, 5, CAST(54.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-15T12:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (6, 27, 6, CAST(59.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-16T13:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (7, 28, 7, CAST(49.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-17T14:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (8, 29, 8, CAST(69.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-18T15:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (9, 22, 9, CAST(59.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-19T16:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (10, 23, 10, CAST(54.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-20T17:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (11, 22, 11, CAST(49.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-21T08:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (12, 23, 12, CAST(79.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-22T09:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (13, 24, 13, CAST(59.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-23T10:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (14, 25, 14, CAST(69.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-24T11:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (15, 26, 15, CAST(54.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-25T12:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (16, 27, 16, CAST(59.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-26T13:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (17, 28, 17, CAST(49.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-27T14:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (18, 29, 18, CAST(64.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-28T15:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (19, 22, 19, CAST(69.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-29T16:00:00.000' AS DateTime), 5)
INSERT [dbo].[transactions] ([id], [student_id], [course_id], [amount], [status], [created_at], [revenue_id]) VALUES (20, 23, 20, CAST(54.99 AS Decimal(10, 2)), N'paid', CAST(N'2024-11-30T17:00:00.000' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[transactions] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Answer] ON 

INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (1, 1, 1, 1)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (2, 2, 2, 2)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (3, 3, 3, 3)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (4, 4, 4, 4)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (5, 5, 5, 5)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (6, 6, 6, 6)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (7, 7, 7, 7)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (8, 8, 8, 8)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (9, 9, 9, 9)
INSERT [dbo].[User_Answer] ([UserAnswerID], [AttemptID], [QuestionID], [OptionID]) VALUES (10, 10, 10, 10)
SET IDENTITY_INSERT [dbo].[User_Answer] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (1, N'John', NULL, N'Doe', N'john.doe@gmail.com', 1, N'John#23', 2, N'https://tinyurl.com/5hyr7rtb', CAST(N'2020-10-01T08:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (2, N'Emma', N'Louise', N'Smith', N'emma.smith@gmail.com', 2, N'Emma!45', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2021-10-02T09:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (3, N'Alex', NULL, N'Taylor', N'alex.taylor@gmail.com', 3, N'alEx&32', 3, NULL, CAST(N'2022-10-03T10:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (4, N'Sarah', N'Jane', N'Brown', N'sarah.brown@gmail.com', 2, N'sArah%20', 1, N'https://tinyurl.com/2exwmnss', CAST(N'2023-10-04T11:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (5, N'Michael', N'James', N'Wilson', N'michael.wilson@gmail.com', 1, N'1wlson@', 2, N'https://tinyurl.com/5hyr7rtb', CAST(N'2019-10-05T12:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (6, N'Lisa', NULL, N'Davis', N'lisa.davis@gmail.com', 2, N'liSa01#', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2021-10-06T13:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (7, N'David', N'Alan', N'Martinez', N'david.martinez@gmail.com', 1, N'dAvid9$', 3, N'https://tinyurl.com/5hyr7rtb', CAST(N'2022-10-07T14:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (8, N'Rachel', N'Marie', N'Clark', N'rachel.clark@gmail.com', 2, N'raHel8&', 2, N'https://tinyurl.com/2exwmnss', CAST(N'2023-10-08T15:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (9, N'Chris', NULL, N'Lee', N'chris.lee@gmail.com', 3, N'clEe55@', 3, NULL, CAST(N'2024-10-09T16:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (10, N'Anna', N'Sophia', N'Walker', N'anna.walker@gmail.com', 2, N'anNa@07', 1, N'https://tinyurl.com/2exwmnss', CAST(N'2024-10-10T17:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (11, N'James', NULL, N'Wilson', N'james.wilson@gmail.com', 1, N'James#5', 2, N'https://tinyurl.com/5hyr7rtb', CAST(N'2024-11-01T08:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (12, N'Emily', N'Rose', N'Thompson', N'emily.thompson@gmail.com', 2, N'Emily$7', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-02T09:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (13, N'Robert', NULL, N'Garcia', N'robert.garcia@gmail.com', 1, N'Rob&456', 3, NULL, CAST(N'2024-11-03T10:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (14, N'Sophia', N'Marie', N'Harris', N'sophia.harris@gmail.com', 2, N'Sophi!1', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-04T11:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (15, N'William', N'Lee', N'Moore', N'william.moore@gmail.com', 1, N'Will#98', 3, N'https://tinyurl.com/5hyr7rtb', CAST(N'2024-11-05T12:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (16, N'Olivia', NULL, N'Young', N'olivia.young@gmail.com', 2, N'Olivi@6', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-06T13:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (17, N'Thomas', N'John', N'King', N'thomas.king@gmail.com', 1, N'Thom%32', 3, NULL, CAST(N'2024-11-07T14:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (18, N'Charlotte', N'Grace', N'Scott', N'charlotte.scott@gmail.com', 2, N'Charl^4', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-08T15:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (19, N'Henry', NULL, N'Green', N'henry.green@gmail.com', 1, N'Henry&7', 3, N'https://tinyurl.com/5hyr7rtb', CAST(N'2024-11-09T16:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (20, N'Mia', N'Elizabeth', N'Adams', N'mia.adams@gmail.com', 2, N'Mia#202', 2, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-10T17:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (21, N'Lucas', NULL, N'Martin', N'lucas.martin@gmail.com', 1, N'Lucas#2', 2, N'https://tinyurl.com/5hyr7rtb', CAST(N'2024-11-11T08:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (22, N'Ava', N'Marie', N'Lewis', N'ava.lewis@gmail.com', 2, N'Ava$789', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-12T09:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (23, N'Ethan', NULL, N'Walker', N'ethan.walker@gmail.com', 1, N'Ethan&4', 3, NULL, CAST(N'2024-11-13T10:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (24, N'Isabella', N'Grace', N'Hall', N'isabella.hall@gmail.com', 2, N'Isabl!1', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-14T11:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (25, N'Mason', N'Lee', N'Young', N'mason.young@gmail.com', 1, N'Mason#9', 3, N'https://tinyurl.com/5hyr7rtb', CAST(N'2024-11-15T12:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (26, N'Sofia', NULL, N'Allen', N'sofia.allen@gmail.com', 2, N'Sofia@6', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-16T13:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (27, N'Logan', N'John', N'King', N'logan.king@gmail.com', 1, N'Logan%3', 3, NULL, CAST(N'2024-11-17T14:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (28, N'Harper', N'Rose', N'Wright', N'harper.wright@gmail.com', 2, N'Harpr^4', 3, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-18T15:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (29, N'Jackson', NULL, N'Scott', N'jackson.scott@gmail.com', 1, N'Jack&7', 3, N'https://tinyurl.com/5hyr7rtb', CAST(N'2024-11-19T16:00:00.000' AS DateTime), 1)
INSERT [dbo].[users] ([id], [first_name], [middle_name], [last_name], [email], [gender_id], [password], [role_id], [avatar_url], [created_at], [status]) VALUES (30, N'Evelyn', N'Sophia', N'Green', N'evelyn.green@gmail.com', 2, N'Evelyn#2025', 2, N'https://tinyurl.com/2exwmnss', CAST(N'2024-11-20T17:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[wishlist] ON 

INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (1, 22, 41, CAST(N'2024-11-11T08:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (2, 23, 42, CAST(N'2024-11-12T09:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (3, 24, 1, CAST(N'2024-11-13T10:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (4, 25, 2, CAST(N'2024-11-14T11:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (5, 26, 3, CAST(N'2024-11-15T12:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (6, 27, 4, CAST(N'2024-11-16T13:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (7, 28, 5, CAST(N'2024-11-17T14:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (8, 29, 6, CAST(N'2024-11-18T15:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (9, 22, 7, CAST(N'2024-11-19T16:00:00.000' AS DateTime))
INSERT [dbo].[wishlist] ([id], [student_id], [course_id], [created_at]) VALUES (10, 23, 8, CAST(N'2024-11-20T17:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[wishlist] OFF
GO
/****** Object:  Index [UC_User_Lesson]    Script Date: 5/8/2025 11:07:22 PM ******/
ALTER TABLE [dbo].[Lesson_Completion] ADD  CONSTRAINT [UC_User_Lesson] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[LessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SystemLogs_AdminId]    Script Date: 5/8/2025 11:07:22 PM ******/
CREATE NONCLUSTERED INDEX [IX_SystemLogs_AdminId] ON [dbo].[SystemLogs]
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SystemLogs_CreatedDate]    Script Date: 5/8/2025 11:07:22 PM ******/
CREATE NONCLUSTERED INDEX [IX_SystemLogs_CreatedDate] ON [dbo].[SystemLogs]
(
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_SystemLogs_TargetType]    Script Date: 5/8/2025 11:07:22 PM ******/
CREATE NONCLUSTERED INDEX [IX_SystemLogs_TargetType] ON [dbo].[SystemLogs]
(
	[TargetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E616420D67F8B]    Script Date: 5/8/2025 11:07:22 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Answer_Option] ADD  DEFAULT ((0)) FOR [IsCorrect]
GO
ALTER TABLE [dbo].[blog_detail] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[blogs] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[commissions] ADD  DEFAULT (getdate()) FOR [effective_from]
GO
ALTER TABLE [dbo].[course_enrollments] ADD  DEFAULT (getdate()) FOR [enrolled_at]
GO
ALTER TABLE [dbo].[course_enrollments] ADD  DEFAULT ('studying') FOR [status]
GO
ALTER TABLE [dbo].[course_enrollments] ADD  DEFAULT ('pending') FOR [refund_status]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[feedback] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Lesson] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Lesson_Completion] ADD  DEFAULT (getdate()) FOR [CompletedAt]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT (getdate()) FOR [paid_at]
GO
ALTER TABLE [dbo].[Quiz] ADD  DEFAULT ((30)) FOR [duration_minutes]
GO
ALTER TABLE [dbo].[Quiz_Attempt] ADD  DEFAULT (getdate()) FOR [AttemptDate]
GO
ALTER TABLE [dbo].[refund_requests] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[revenue] ADD  DEFAULT (getdate()) FOR [generated_at]
GO
ALTER TABLE [dbo].[SystemLogs] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[teacher_requests] ADD  DEFAULT (getdate()) FOR [request_date]
GO
ALTER TABLE [dbo].[teacher_requests] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[teacher_salary] ADD  DEFAULT ((0)) FOR [paid]
GO
ALTER TABLE [dbo].[teacher_salary] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[transactions] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[wishlist] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Answer_Option]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([QuestionID])
GO
ALTER TABLE [dbo].[blogs]  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([id])
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[course_enrollments]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([id])
GO
ALTER TABLE [dbo].[course_enrollments]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([id])
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD FOREIGN KEY([teacher_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([id])
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[Lesson]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[courses] ([id])
GO
ALTER TABLE [dbo].[Lesson_Completion]  WITH CHECK ADD FOREIGN KEY([LessonID])
REFERENCES [dbo].[Lesson] ([LessonID])
GO
ALTER TABLE [dbo].[Lesson_Completion]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [FK_order_detail_courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([id])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [FK_order_detail_courses]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [FK_order_detail_orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [FK_order_detail_orders]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_users]
GO
ALTER TABLE [dbo].[payments]  WITH CHECK ADD FOREIGN KEY([transaction_id])
REFERENCES [dbo].[transactions] ([id])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD FOREIGN KEY([QuizID])
REFERENCES [dbo].[Quiz] ([QuizID])
GO
ALTER TABLE [dbo].[Quiz]  WITH CHECK ADD FOREIGN KEY([LessonID])
REFERENCES [dbo].[Lesson] ([LessonID])
GO
ALTER TABLE [dbo].[Quiz_Attempt]  WITH CHECK ADD FOREIGN KEY([QuizID])
REFERENCES [dbo].[Quiz] ([QuizID])
GO
ALTER TABLE [dbo].[Quiz_Attempt]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[refund_requests]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([id])
GO
ALTER TABLE [dbo].[refund_requests]  WITH CHECK ADD FOREIGN KEY([enrollment_id])
REFERENCES [dbo].[course_enrollments] ([id])
GO
ALTER TABLE [dbo].[refund_requests]  WITH CHECK ADD FOREIGN KEY([processed_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[refund_requests]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[revenue]  WITH CHECK ADD FOREIGN KEY([commission_id])
REFERENCES [dbo].[commissions] ([id])
GO
ALTER TABLE [dbo].[SystemLogs]  WITH CHECK ADD  CONSTRAINT [FK_SystemLogs_Admin] FOREIGN KEY([AdminId])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[SystemLogs] CHECK CONSTRAINT [FK_SystemLogs_Admin]
GO
ALTER TABLE [dbo].[teacher_requests]  WITH CHECK ADD FOREIGN KEY([approver_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[teacher_requests]  WITH CHECK ADD FOREIGN KEY([requester_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [FK_teacher_salary_last_modified_by] FOREIGN KEY([last_modified_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [FK_teacher_salary_last_modified_by]
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [FK_teacher_salary_teacher_id] FOREIGN KEY([teacher_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [FK_teacher_salary_teacher_id]
GO
ALTER TABLE [dbo].[teacher_subjects]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subjects] ([id])
GO
ALTER TABLE [dbo].[teacher_subjects]  WITH CHECK ADD FOREIGN KEY([teacher_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([id])
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD FOREIGN KEY([revenue_id])
REFERENCES [dbo].[revenue] ([id])
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[User_Answer]  WITH CHECK ADD FOREIGN KEY([AttemptID])
REFERENCES [dbo].[Quiz_Attempt] ([AttemptID])
GO
ALTER TABLE [dbo].[User_Answer]  WITH CHECK ADD FOREIGN KEY([OptionID])
REFERENCES [dbo].[Answer_Option] ([OptionID])
GO
ALTER TABLE [dbo].[User_Answer]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([QuestionID])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD FOREIGN KEY([gender_id])
REFERENCES [dbo].[genders] ([id])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([id])
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[category]  WITH CHECK ADD CHECK  (([semester]='semester 9' OR [semester]='semester 8' OR [semester]='semester 7' OR [semester]='semester 6' OR [semester]='semester 5' OR [semester]='semester 4' OR [semester]='semester 3' OR [semester]='semester 2' OR [semester]='semester 1'))
GO
ALTER TABLE [dbo].[course_enrollments]  WITH CHECK ADD CHECK  (([refund_status]='rejected' OR [refund_status]='refunded' OR [refund_status]='pending'))
GO
ALTER TABLE [dbo].[course_enrollments]  WITH CHECK ADD  CONSTRAINT [CK__course_en__statu__6166761E] CHECK  (([status]='quit' OR [status]='pause' OR [status]='completed' OR [status]='studying'))
GO
ALTER TABLE [dbo].[course_enrollments] CHECK CONSTRAINT [CK__course_en__statu__6166761E]
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD CHECK  (([status]='inactive' OR [status]='active'))
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD CHECK  (([status]='hidden' OR [status]='visible'))
GO
ALTER TABLE [dbo].[payments]  WITH CHECK ADD CHECK  (([payment_status]='failed' OR [payment_status]='pending' OR [payment_status]='success'))
GO
ALTER TABLE [dbo].[revenue]  WITH CHECK ADD CHECK  (([month]>=(1) AND [month]<=(12)))
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [CHK_commission_amount] CHECK  (([commission_amount]>=(0)))
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [CHK_commission_amount]
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [CHK_commission_rate] CHECK  (([commission_rate]>=(0) AND [commission_rate]<=(100)))
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [CHK_commission_rate]
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [CHK_gross_amount] CHECK  (([gross_amount]>=(0)))
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [CHK_gross_amount]
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [CHK_month] CHECK  (([month]>=(1) AND [month]<=(12)))
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [CHK_month]
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [CHK_status] CHECK  (([status]='Disputed' OR [status]='Paid' OR [status]='Approved' OR [status]='Pending'))
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [CHK_status]
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [CHK_total_amount] CHECK  (([total_amount]>=(0)))
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [CHK_total_amount]
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [CHK_transaction_count] CHECK  (([transaction_count]>=(0)))
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [CHK_transaction_count]
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD  CONSTRAINT [CHK_year] CHECK  (([year]>=(2000) AND [year]<=(datepart(year,getdate())+(1))))
GO
ALTER TABLE [dbo].[teacher_salary] CHECK CONSTRAINT [CHK_year]
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD CHECK  (([status]='failed' OR [status]='pending' OR [status]='paid'))
GO
/****** Object:  StoredProcedure [dbo].[GenerateTeacherPayroll]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[GenerateTeacherPayroll]
		@Month INT,
		@Year INT,
		@AdminID INT = NULL
	AS
	BEGIN
		SET NOCOUNT ON;

		-- Validate input
		IF @Month NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
			THROW 50001, 'Invalid month. Must be between 1 and 12.', 1;
		IF @Year < 2000 OR @Year > YEAR(GETDATE())
			THROW 50002, 'Invalid year. Must be between 2000 and current year.', 1;
		IF @AdminID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM [dbo].[users] WHERE id = @AdminID AND role_id = 1)
			THROW 50003, 'Invalid admin ID. Must reference a user with Admin role.', 1;

		BEGIN TRY
			BEGIN TRANSACTION;

			-- Lấy commission rate mới nhất từ bảng commissions
			DECLARE @CommissionRate DECIMAL(5,2);
			SELECT @CommissionRate = rate
			FROM [dbo].[commissions]
			WHERE effective_from <= GETDATE()
			ORDER BY effective_from DESC, id DESC
			OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;

			-- Nếu không có commission rate, sử dụng mặc định là 20%
			IF @CommissionRate IS NULL
				SET @CommissionRate = 20.00;

			-- Insert chỉ khi chưa tồn tại payroll cho giáo viên, tháng và năm này
			INSERT INTO [dbo].[teacher_salary] (
				teacher_id, 
				gross_amount, 
				commission_rate, 
				commission_amount, 
				total_amount, 
				month, 
				year, 
				transaction_count, 
				paid,  -- Explicitly set to 0 (unpaid)
				status, 
				last_modified_by,
				created_at
			)
			SELECT 
				u.id AS teacher_id,
				COALESCE(SUM(t.amount), 0) AS gross_amount,
				@CommissionRate AS commission_rate,
				COALESCE(SUM(t.amount) * @CommissionRate / 100, 0) AS commission_amount,
				COALESCE(SUM(t.amount) * (1 - @CommissionRate / 100), 0) AS total_amount,
				@Month,
				@Year,
				COUNT(t.id) AS transaction_count,
				0 AS paid,  -- Ensure new records are unpaid
				'Pending' AS status,
				@AdminID AS last_modified_by,
				GETDATE() AS created_at
			FROM [dbo].[users] u
			INNER JOIN [dbo].[courses] c ON u.id = c.teacher_id
			INNER JOIN [dbo].[transactions] t ON c.id = t.course_id
			WHERE u.role_id = 2 -- Teachers only
				AND t.status = 'paid'
				AND MONTH(t.created_at) = @Month
				AND YEAR(t.created_at) = @Year
				AND NOT EXISTS (  -- Prevent duplicates
					SELECT 1 
					FROM [dbo].[teacher_salary] ts 
					WHERE ts.teacher_id = u.id 
					AND ts.month = @Month 
					AND ts.year = @Year
				)
			GROUP BY u.id
			HAVING SUM(t.amount) > 0;

			COMMIT TRANSACTION;
			PRINT 'Payroll generated successfully for ' + CAST(@Month AS VARCHAR) + '/' + CAST(@Year AS VARCHAR);
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
			THROW 50004, @ErrorMessage, 1;
		END CATCH;
	END;
GO
/****** Object:  StoredProcedure [dbo].[MarkTeacherSalaryPaid]    Script Date: 5/8/2025 11:07:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE   PROCEDURE [dbo].[MarkTeacherSalaryPaid]
		@SalaryID INT,
		@AdminID INT = NULL
	AS
	BEGIN
		SET NOCOUNT ON;

		BEGIN TRY
			BEGIN TRANSACTION;

			-- Validate salary ID
			IF NOT EXISTS (SELECT 1 FROM [dbo].[teacher_salary] WHERE id = @SalaryID)
				THROW 50005, 'Invalid salary ID.', 1;

			-- Validate admin ID
			IF @AdminID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM [dbo].[users] WHERE id = @AdminID AND role_id = 1)
				THROW 50006, 'Invalid admin ID. Must reference a user with Admin role.', 1;

			-- Update paid status
			UPDATE [dbo].[teacher_salary]
			SET paid = 1,
				last_modified_by = @AdminID,
				status = 'Paid'
			WHERE id = @SalaryID;

			COMMIT TRANSACTION;
			PRINT 'Salary ID ' + CAST(@SalaryID AS VARCHAR) + ' marked as paid.';
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
			THROW 50007, @ErrorMessage, 1;
		END CATCH;
	END;
GO
USE [master]
GO
ALTER DATABASE [Onlinelearning] SET  READ_WRITE 
GO
