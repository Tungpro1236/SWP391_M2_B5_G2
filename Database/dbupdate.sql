USE [master]
GO
/****** Object:  Database [Onlinelearning]    Script Date: 4/16/2025 11:43:10 AM ******/
CREATE DATABASE [Onlinelearning]
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
/****** Object:  Table [dbo].[blogs]    Script Date: 4/16/2025 11:43:10 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[category]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[commissions]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[course_enrollments]    Script Date: 4/16/2025 11:43:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_enrollments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[course_id] [int] NULL,
	[enrolled_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[feedback]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[genders]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[payments]    Script Date: 4/16/2025 11:43:10 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[revenue]    Script Date: 4/16/2025 11:43:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[revenue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[total_amount] [decimal](15, 2) NOT NULL,
	[commission_id] [int] NULL,
	[commission_rate] [decimal](5, 2) NULL,
	[commission_amount]  AS (([total_amount]*[commission_rate])/(100.0)) PERSISTED,
	[month] [int] NULL,
	[year] [int] NULL,
	[generated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[subjects]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[teacher_salary]    Script Date: 4/16/2025 11:43:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teacher_salary](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teacher_id] [int] NULL,
	[total_amount] [decimal](10, 2) NULL,
	[month] [int] NULL,
	[year] [int] NULL,
	[paid] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teacher_subjects]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[transactions]    Script Date: 4/16/2025 11:43:10 AM ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 4/16/2025 11:43:10 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wishlist]    Script Date: 4/16/2025 11:43:10 AM ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E6164499CC7F8]    Script Date: 4/16/2025 11:43:10 AM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[blogs] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[commissions] ADD  DEFAULT (getdate()) FOR [effective_from]
GO
ALTER TABLE [dbo].[course_enrollments] ADD  DEFAULT (getdate()) FOR [enrolled_at]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[courses] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[feedback] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT (getdate()) FOR [paid_at]
GO
ALTER TABLE [dbo].[revenue] ADD  DEFAULT (getdate()) FOR [generated_at]
GO
ALTER TABLE [dbo].[teacher_salary] ADD  DEFAULT ((0)) FOR [paid]
GO
ALTER TABLE [dbo].[transactions] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[wishlist] ADD  DEFAULT (getdate()) FOR [created_at]
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
ALTER TABLE [dbo].[payments]  WITH CHECK ADD FOREIGN KEY([transaction_id])
REFERENCES [dbo].[transactions] ([id])
GO
ALTER TABLE [dbo].[revenue]  WITH CHECK ADD FOREIGN KEY([commission_id])
REFERENCES [dbo].[commissions] ([id])
GO
ALTER TABLE [dbo].[teacher_salary]  WITH CHECK ADD FOREIGN KEY([teacher_id])
REFERENCES [dbo].[users] ([id])
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
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD CHECK  (([status]='failed' OR [status]='pending' OR [status]='paid'))
GO
USE [master]
GO
ALTER DATABASE [Onlinelearning] SET  READ_WRITE 
GO
USE [Onlinelearning];
GO
-- Tạo bảng Lesson
IF OBJECT_ID('Lesson', 'U') IS NULL
BEGIN
    CREATE TABLE Lesson (
        LessonID INT PRIMARY KEY IDENTITY,
        CourseID INT NOT NULL,
        Title NVARCHAR(255) NOT NULL,
        Content NVARCHAR(MAX),
        VideoURL NVARCHAR(500),
        CreatedAt DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (CourseID) REFERENCES Courses(id)
    );
END

-- Tạo bảng Lesson_Completion
IF OBJECT_ID('Lesson_Completion', 'U') IS NULL
BEGIN
    CREATE TABLE Lesson_Completion (
        CompletionID INT PRIMARY KEY IDENTITY,
        UserID INT NOT NULL,
        LessonID INT NOT NULL,
        CompletedAt DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (UserID) REFERENCES Users(id),
        FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID),
        CONSTRAINT UC_User_Lesson UNIQUE (UserID, LessonID)
    );
END

-- Tạo bảng Quiz
IF OBJECT_ID('Quiz', 'U') IS NULL
BEGIN
    CREATE TABLE Quiz (
        QuizID INT PRIMARY KEY IDENTITY,
        LessonID INT NOT NULL,
        Title NVARCHAR(255),
        FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID)
    );
END

-- Tạo bảng Quiz_Attempt
IF OBJECT_ID('Quiz_Attempt', 'U') IS NULL
BEGIN
    CREATE TABLE Quiz_Attempt (
        AttemptID INT PRIMARY KEY IDENTITY,
        UserID INT NOT NULL,
        QuizID INT NOT NULL,
        AttemptDate DATETIME DEFAULT GETDATE(),
        Score DECIMAL(5,2),
        FOREIGN KEY (UserID) REFERENCES Users(id),
        FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID)
    );
END

-- Tạo bảng Question
IF OBJECT_ID('Question', 'U') IS NULL
BEGIN
    CREATE TABLE Question (
        QuestionID INT PRIMARY KEY IDENTITY,
        QuizID INT NOT NULL,
        Text NVARCHAR(MAX),
        FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID)
    );
END

-- Tạo bảng Answer_Option
IF OBJECT_ID('Answer_Option', 'U') IS NULL
BEGIN
    CREATE TABLE Answer_Option (
        OptionID INT PRIMARY KEY IDENTITY,
        QuestionID INT NOT NULL,
        Text NVARCHAR(500),
        IsCorrect BIT NOT NULL DEFAULT 0,
        FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
    );
END

-- Tạo bảng User_Answer
IF OBJECT_ID('User_Answer', 'U') IS NULL
BEGIN
    CREATE TABLE User_Answer (
        UserAnswerID INT PRIMARY KEY IDENTITY,
        AttemptID INT NOT NULL,
        QuestionID INT NOT NULL,
        OptionID INT,
        FOREIGN KEY (AttemptID) REFERENCES Quiz_Attempt(AttemptID),
        FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID),
        FOREIGN KEY (OptionID) REFERENCES Answer_Option(OptionID)
    );
END

-- ALTER bảng Quiz - thêm cột duration_minutes
IF COL_LENGTH('Quiz', 'duration_minutes') IS NULL
BEGIN
    ALTER TABLE Quiz
    ADD duration_minutes INT NOT NULL DEFAULT 30;
END

-- ALTER bảng Quiz_Attempt - thêm cột completion_time_minutes
IF COL_LENGTH('Quiz_Attempt', 'completion_time_minutes') IS NULL
BEGIN
    ALTER TABLE Quiz_Attempt
    ADD completion_time_minutes INT NULL;
END
-- ALTER bảng Courses - thêm cột price
IF COL_LENGTH('Courses', 'price') IS NULL
BEGIN
    ALTER TABLE Courses
    ADD price DECIMAL(10, 2);
END