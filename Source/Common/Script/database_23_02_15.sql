USE [master]
GO
/****** Object:  Database [FLMS_DB]    Script Date: 2/15/2023 11:33:34 PM ******/
CREATE DATABASE [FLMS_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FLMS_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER07\MSSQL\DATA\FLMS_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FLMS_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER07\MSSQL\DATA\FLMS_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FLMS_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FLMS_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FLMS_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FLMS_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FLMS_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FLMS_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FLMS_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FLMS_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FLMS_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FLMS_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FLMS_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FLMS_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FLMS_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FLMS_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FLMS_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FLMS_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FLMS_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FLMS_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FLMS_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FLMS_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FLMS_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FLMS_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FLMS_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FLMS_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FLMS_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [FLMS_DB] SET  MULTI_USER 
GO
ALTER DATABASE [FLMS_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FLMS_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FLMS_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FLMS_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FLMS_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FLMS_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FLMS_DB', N'ON'
GO
ALTER DATABASE [FLMS_DB] SET QUERY_STORE = OFF
GO
USE [FLMS_DB]
GO
/****** Object:  Table [dbo].[Club]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Club](
	[ClubId] [int] IDENTITY(1,1) NOT NULL,
	[ClubName] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
	[CreateAt] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Club] PRIMARY KEY CLUSTERED 
(
	[ClubId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClubLeague]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClubLeague](
	[ClubLeagueId] [int] IDENTITY(1,1) NOT NULL,
	[ClubName] [nvarchar](1) NOT NULL,
	[ClubId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClubLeagueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[League]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[League](
	[LeagueId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[LeagueName] [nvarchar](100) NOT NULL,
	[NoParticipate] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[MaxNoPlayer] [int] NOT NULL,
	[NoPlayerSquad] [int] NOT NULL,
	[Location] [nvarchar](255) NULL,
	[Fanpage] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[LeagueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeagueFee]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeagueFee](
	[LeagueFeeId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NULL,
	[ExpenseKey] [nvarchar](10) NULL,
	[ExpenseName] [nvarchar](50) NULL,
	[Cost] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[LeagueFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Match]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Match](
	[MatchId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[HomeId] [int] NOT NULL,
	[AwayId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatchEvent]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchEvent](
	[MatchEventId] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NOT NULL,
	[SupportId] [int] NULL,
	[MatchId] [int] NOT NULL,
	[EventType] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MatchEventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatchStat]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchStat](
	[MatchStatId] [int] IDENTITY(1,1) NOT NULL,
	[MatchId] [int] NOT NULL,
	[IsHome] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MatchStatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Participation]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participation](
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[PlayerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[NickName] [nvarchar](20) NOT NULL,
	[Number] [int] NULL,
	[Dob] [datetime] NULL,
	[Height] [nvarchar](10) NULL,
	[Weight] [nvarchar](10) NULL,
	[Address] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[Email] [nvarchar](255) NULL,
	[SocialCont] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerClub]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerClub](
	[PlayerId] [int] NOT NULL,
	[ClubId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshToken](
	[TokenId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[TokenHash] [nvarchar](1000) NOT NULL,
	[TokenSalt] [nvarchar](1000) NOT NULL,
	[CreateAt] [smalldatetime] NOT NULL,
	[ExpiryDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_RefreshToken] PRIMARY KEY CLUSTERED 
(
	[TokenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
	[RequestType] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2/15/2023 11:33:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[PasswordSalt] [nvarchar](255) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Active] [bit] NOT NULL,
	[CreateAt] [smalldatetime] NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[RefreshToken] ON 

INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (25, 7, N'gqozd1zJJMWsAB8KYFw0OK/gJPprPUIVdSQCEtocp3c=', N'3C4yiSJn09FOhmTbfj9iTydK2WGUgW7RiFAs+JxD/+4=', CAST(N'2023-02-03T21:24:00' AS SmallDateTime), CAST(N'2023-02-03T21:25:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (27, 8, N'o51/t8SukSEO0ziGTaZrlpRisSHbkvXRR7nnyUUHR7U=', N'lJJO9etrl5uaNj3YzwpK26NL1zphTlaax5UccFCdrSA=', CAST(N'2023-02-05T23:17:00' AS SmallDateTime), CAST(N'2023-02-05T23:18:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (31, 4, N'1PMf8kmzr6/c5dqmfcB5WmeoJQlJAX6fjCjEsipDFBo=', N'vlOTYZqmPInffUqo7OGbjNeFBvtsfT3kIWxs2KwvF5k=', CAST(N'2023-02-14T17:29:00' AS SmallDateTime), CAST(N'2023-02-14T17:30:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[RefreshToken] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (1, N'abc@gmail.com', N'123', N'abc', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2022-01-06T00:00:00' AS SmallDateTime), N'MEMBER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (4, N'ninhkhoai2106@gmail.com', N'5n3kwlT8gvuZtL4AZexsZFKLlNCcHczFlE2NRBs4PDE=', N'58MEo0ZtKXtt6prq28aAZ3Q1f5/Eq/JlV/ghTm0B9Z8=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T18:32:00' AS SmallDateTime), N'MEMBER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (5, N'ucanh21066@gmail.com', N'HSNoT7VG5m5DtXavXyVXvo2Gkjyhh+MkomLkRVq1QJ0=', N'BV3fOmLd8xKuyZNlSMYlu3RPf+mcGUjQQlQH8B+AyLI=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T18:33:00' AS SmallDateTime), N'MEMBER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (6, N'ducanh21066@gmail.com', N'TdImUxZrysf+nspt0lS7sy3dYPVGrLrZFROVK+qoTsE=', N'QS6oiuZh0CZdBl8qn62bpJKp5E8nsZ11gzv1GV7i9kI=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T18:34:00' AS SmallDateTime), N'MEMBER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (7, N'ducanh2106@gmail.com', N'sw1XzB7iLM/KQyRliQCgnIWuS8IVpiJ0MKna6ws4G2k=', N'UXClFXlEawuqFWgajEHSJDOcNtkTVxZQn744UW9yctM=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T19:03:00' AS SmallDateTime), N'ADMIN')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (8, N'leagueManager@gmail.com', N'VrgBRXxtcHzQODRt1OOTAHkvmx185wkTmUXsAhucISI=', N'fZCgMhVSWNuYTqH3JGg8EqyfWYgEJfrkxj5oh6Uvp54=', N'League Mana', N'09123456', N'abcdef', 1, CAST(N'2023-02-05T23:12:00' AS SmallDateTime), N'LEAGUE_MANAGER')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD  CONSTRAINT [FK_Club_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club] CHECK CONSTRAINT [FK_Club_User]
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD FOREIGN KEY([MainId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD FOREIGN KEY([SupportId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD  CONSTRAINT [FK_RefreshToken_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken] CHECK CONSTRAINT [FK_RefreshToken_User]
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD CHECK  (([EventType]='RedCard' OR [EventType]='YellowCard' OR [EventType]='Goal'))
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD CHECK  (([RequestType]='Register' OR [RequestType]='Invite'))
GO
USE [master]
GO
ALTER DATABASE [FLMS_DB] SET  READ_WRITE 
GO
