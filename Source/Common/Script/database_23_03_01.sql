USE [master]
GO
/****** Object:  Database [FLMS_DB]    Script Date: 3/1/2023 2:35:33 PM ******/
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
/****** Object:  Table [dbo].[Club]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Club](
	[ClubId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ClubName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](200) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[SocialCont] [nvarchar](255) NULL,
	[CreateAt] [datetime] NOT NULL,
	[Logo] [nvarchar](max) NULL,
	[Kit] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClubId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClubClone]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClubClone](
	[ClubCloneId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NULL,
	[ClubCloneKey] [nchar](10) NOT NULL,
 CONSTRAINT [PK_ClubClone] PRIMARY KEY CLUSTERED 
(
	[ClubCloneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClubLeague]    Script Date: 3/1/2023 2:35:33 PM ******/
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
/****** Object:  Table [dbo].[League]    Script Date: 3/1/2023 2:35:33 PM ******/
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
	[CreateAt] [datetime] NOT NULL,
	[Description] [text] NULL,
	[LeagueType] [nvarchar](50) NOT NULL,
	[NoRound] [int] NULL,
	[Logo] [nvarchar](max) NULL,
 CONSTRAINT [PK__League__10ABBCF4E505BDC3] PRIMARY KEY CLUSTERED 
(
	[LeagueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeagueFee]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeagueFee](
	[LeagueFeeId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ExpenseKey] [nvarchar](10) NOT NULL,
	[ExpenseName] [nvarchar](50) NOT NULL,
	[Cost] [money] NOT NULL,
	[IsActual] [bit] NOT NULL,
 CONSTRAINT [PK__LeagueFe__3502577D95B2FF37] PRIMARY KEY CLUSTERED 
(
	[LeagueFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Match]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Match](
	[MatchId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[HomeId] [int] NOT NULL,
	[AwayId] [int] NOT NULL,
	[MatchDate] [datetime] NOT NULL,
	[IsFinish] [bit] NOT NULL,
 CONSTRAINT [PK__Match__4218C817BFC20F75] PRIMARY KEY CLUSTERED 
(
	[MatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatchEvent]    Script Date: 3/1/2023 2:35:33 PM ******/
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
/****** Object:  Table [dbo].[MatchStat]    Script Date: 3/1/2023 2:35:33 PM ******/
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
/****** Object:  Table [dbo].[ParticipateNode]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParticipateNode](
	[ParticipateNodeId] [int] IDENTITY(1,1) NOT NULL,
	[ParticipateId] [int] NOT NULL,
	[ClubCloneId] [int] NULL,
	[Deep] [int] NOT NULL,
	[ParentId] [int] NULL,
	[LeftId] [int] NULL,
	[RightId] [int] NULL,
	[LeagueId] [int] NOT NULL,
 CONSTRAINT [PK_ParticipateNode] PRIMARY KEY CLUSTERED 
(
	[ParticipateNodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParticipateRequest]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParticipateRequest](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
	[RequestType] [nvarchar](255) NOT NULL,
	[RequestStatus] [nvarchar](50) NOT NULL,
	[RequestDate] [datetime] NOT NULL,
 CONSTRAINT [PK__Request__33A8517A9027761E] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Participation]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participation](
	[ParticipationId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
 CONSTRAINT [PK_Participation] PRIMARY KEY CLUSTERED 
(
	[ParticipationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[PlayerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[NickName] [nvarchar](20) NOT NULL,
	[Dob] [datetime] NULL,
	[Height] [nvarchar](10) NULL,
	[Weight] [nvarchar](10) NULL,
	[Address] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[Email] [nvarchar](255) NULL,
	[SocialCont] [nvarchar](255) NULL,
	[Avatar] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerClub]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerClub](
	[PlayerClubId] [int] IDENTITY(1,1) NOT NULL,
	[PlayerId] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
	[Number] [int] NOT NULL,
 CONSTRAINT [PK_PlayerClub] PRIMARY KEY CLUSTERED 
(
	[PlayerClubId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 3/1/2023 2:35:33 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[TokenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/1/2023 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[PasswordSalt] [varchar](255) NOT NULL,
	[FullName] [varchar](100) NOT NULL,
	[Phone] [varchar](15) NULL,
	[Address] [varchar](255) NULL,
	[Active] [bit] NOT NULL,
	[CreateAt] [datetime] NOT NULL,
	[Role] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Club] ON 

INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (1, 9, N'club test', N'abc', N'test', N'test', CAST(N'2023-02-17T15:47:17.953' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (2, 9, N'Club 2', N'club1@gmail.com', N'0912345678', N'abcdef', CAST(N'2023-02-17T15:50:58.820' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (3, 9, N'Club 3', N'club1@gmail.com', N'0912345678', N'abcdef', CAST(N'2023-02-17T16:04:48.077' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (4, 9, N'Club A', N'ClubA@gmail.com', N'1234567890', N'abc', CAST(N'2023-02-27T20:38:36.253' AS DateTime), N'images/abc', N'images/def')
SET IDENTITY_INSERT [dbo].[Club] OFF
GO
SET IDENTITY_INSERT [dbo].[ClubClone] ON 

INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (1, 1, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (2, 1, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (3, 1, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (4, 1, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (5, 1, NULL, N'C5        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (6, 2, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (7, 2, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (8, 2, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (9, 2, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (10, 2, NULL, N'C5        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (11, 2, NULL, N'C6        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (12, 2, NULL, N'C7        ')
SET IDENTITY_INSERT [dbo].[ClubClone] OFF
GO
SET IDENTITY_INSERT [dbo].[League] ON 

INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo]) VALUES (1, 10, N'League Knock-out 5 team', 5, CAST(N'2023-02-28T17:00:00.000' AS DateTime), CAST(N'2023-03-15T17:00:00.000' AS DateTime), 20, 11, N'Hoa Lac', N'fuhoalac', CAST(N'2023-02-26T15:25:50.800' AS DateTime), NULL, N'KO', 1, NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo]) VALUES (2, 10, N'League Round table 7 team', 7, CAST(N'2023-02-28T17:00:00.000' AS DateTime), CAST(N'2023-03-15T17:00:00.000' AS DateTime), 20, 11, N'FPT Hoa Lac', N'fuhoalac', CAST(N'2023-02-26T15:29:10.363' AS DateTime), NULL, N'LEAGUE', 1, NULL)
SET IDENTITY_INSERT [dbo].[League] OFF
GO
SET IDENTITY_INSERT [dbo].[LeagueFee] ON 

INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (1, 1, N'A', N'Gold Medal', 50000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (2, 1, N'B', N'Silver Medal', 25000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (3, 1, N'C', N'Bronze Medal', 15000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (4, 2, N'A', N'Gold Medal', 20000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (5, 2, N'B', N'Silver Medal', 10000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (6, 2, N'C', N'Bronze Medal', 5000.0000, 0)
SET IDENTITY_INSERT [dbo].[LeagueFee] OFF
GO
SET IDENTITY_INSERT [dbo].[Match] ON 

INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (1, 1, 2, 1, CAST(N'2023-03-15T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (2, 1, 3, 5, CAST(N'2023-03-13T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (3, 1, 7, 6, CAST(N'2023-03-13T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (4, 1, 9, 8, CAST(N'2023-03-11T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (5, 2, 11, 10, CAST(N'2023-02-28T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (6, 2, 13, 12, CAST(N'2023-02-28T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (7, 2, 15, 14, CAST(N'2023-02-28T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (8, 2, 16, 10, CAST(N'2023-03-02T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (9, 2, 13, 11, CAST(N'2023-03-02T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (10, 2, 14, 12, CAST(N'2023-03-02T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (11, 2, 13, 10, CAST(N'2023-03-04T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (12, 2, 15, 16, CAST(N'2023-03-04T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (13, 2, 14, 11, CAST(N'2023-03-04T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (14, 2, 15, 10, CAST(N'2023-03-06T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (15, 2, 14, 13, CAST(N'2023-03-06T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (16, 2, 12, 16, CAST(N'2023-03-06T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (17, 2, 14, 10, CAST(N'2023-03-08T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (18, 2, 12, 15, CAST(N'2023-03-08T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (19, 2, 11, 16, CAST(N'2023-03-08T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (20, 2, 12, 10, CAST(N'2023-03-10T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (21, 2, 11, 15, CAST(N'2023-03-10T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (22, 2, 16, 13, CAST(N'2023-03-10T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (23, 2, 11, 12, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (24, 2, 16, 14, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (25, 2, 13, 15, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Match] OFF
GO
SET IDENTITY_INSERT [dbo].[ParticipateNode] ON 

INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (1, 3, NULL, 2, 1, 6, 7, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (2, 2, NULL, 2, 1, 4, 5, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (3, 4, NULL, 3, 2, 8, 9, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (4, 1, NULL, 1, 0, 2, 3, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (5, 5, 1, 3, 2, 0, 0, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (6, 7, 3, 3, 3, 0, 0, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (7, 6, 2, 3, 3, 0, 0, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (8, 9, 5, 4, 4, 0, 0, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (9, 8, 4, 4, 4, 0, 0, 1)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (10, 0, 6, 0, NULL, NULL, NULL, 2)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (11, 0, 7, 0, NULL, NULL, NULL, 2)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (12, 0, 12, 0, NULL, NULL, NULL, 2)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (13, 0, 9, 0, NULL, NULL, NULL, 2)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (14, 0, 11, 0, NULL, NULL, NULL, 2)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (15, 0, 10, 0, NULL, NULL, NULL, 2)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (16, 0, 8, 0, NULL, NULL, NULL, 2)
SET IDENTITY_INSERT [dbo].[ParticipateNode] OFF
GO
SET IDENTITY_INSERT [dbo].[ParticipateRequest] ON 

INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (4, 1, 4, N'Invite', N'Canceled', CAST(N'2023-03-01T00:13:11.977' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (6, 2, 3, N'Invite', N'Rejected', CAST(N'2023-03-01T10:30:08.853' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (8, 1, 3, N'Register', N'Accepted', CAST(N'2023-03-01T10:33:27.750' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (9, 2, 4, N'Register', N'Rejected', CAST(N'2023-03-01T10:33:44.340' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (10, 1, 4, N'Invite', N'Accepted', CAST(N'2023-03-01T13:48:57.730' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (11, 2, 3, N'Register', N'Rejected', CAST(N'2023-03-01T14:02:54.960' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (12, 2, 2, N'Invite', N'Accepted', CAST(N'2023-03-01T14:27:35.113' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (13, 2, 3, N'Invite', N'Accepted', CAST(N'2023-03-01T14:30:04.940' AS DateTime))
SET IDENTITY_INSERT [dbo].[ParticipateRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[Participation] ON 

INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId]) VALUES (1, 1, 3)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId]) VALUES (2, 1, 4)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId]) VALUES (3, 2, 2)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId]) VALUES (4, 2, 3)
SET IDENTITY_INSERT [dbo].[Participation] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (2, N'Player 1', N'anh', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (3, N'Player 2', N'anh2', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
SET IDENTITY_INSERT [dbo].[PlayerClub] ON 

INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (1, 2, 4, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (2, 2, 3, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (3, 3, 3, 7)
SET IDENTITY_INSERT [dbo].[PlayerClub] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshToken] ON 

INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (25, 7, N'gqozd1zJJMWsAB8KYFw0OK/gJPprPUIVdSQCEtocp3c=', N'3C4yiSJn09FOhmTbfj9iTydK2WGUgW7RiFAs+JxD/+4=', CAST(N'2023-02-03T21:24:00' AS SmallDateTime), CAST(N'2023-02-03T21:25:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (27, 8, N'o51/t8SukSEO0ziGTaZrlpRisSHbkvXRR7nnyUUHR7U=', N'lJJO9etrl5uaNj3YzwpK26NL1zphTlaax5UccFCdrSA=', CAST(N'2023-02-05T23:17:00' AS SmallDateTime), CAST(N'2023-02-05T23:18:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (88, 4, N'XhbTvHyzpKnMAZY0PvLwpKazBNY+1xg7KKfEPkiARE8=', N'H2+btyX0N5sj2SVEJ9JxIc5c2iojG4KnrkB9R+6SgOc=', CAST(N'2023-02-28T09:43:00' AS SmallDateTime), CAST(N'2023-02-28T09:44:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (97, 11, N'v9QEfKDz6kmFRoDrR2QTyhQppE5uS9VITfG3AMIssMA=', N'hfyuiM7DmP9DAZX851Jp4GiAeTVjILlC0EOlh2Gb8iI=', CAST(N'2023-03-01T10:11:00' AS SmallDateTime), CAST(N'2023-03-01T10:12:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (107, 10, N'/snKY2sCXS52o6PGW/eOMGvpXZhVxlmsoBx3xsa/NCc=', N'k1ieu3c7RCpV+Ekhb0IqSe6SdC5y7RTQOoN25dFrgn0=', CAST(N'2023-03-01T14:27:00' AS SmallDateTime), CAST(N'2023-03-01T14:28:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (108, 9, N'ntVezzRYvDQhtWHl731bg6RuAwGjmuqxBkiz9uS29XI=', N'WnOVc/8oJ8Ht84UN+qEEtD0/YSOUNJyamwzxY/ZA18Y=', CAST(N'2023-03-01T14:31:00' AS SmallDateTime), CAST(N'2023-03-01T14:32:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[RefreshToken] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (1, N'abc@gmail.com', N'123', N'abc', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2022-01-06T00:00:00.000' AS DateTime), N'CLUB_MANAGER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (4, N'ninhkhoai2106@gmail.com', N'5n3kwlT8gvuZtL4AZexsZFKLlNCcHczFlE2NRBs4PDE=', N'58MEo0ZtKXtt6prq28aAZ3Q1f5/Eq/JlV/ghTm0B9Z8=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T18:32:00.000' AS DateTime), N'LEAGUE_MANAGER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (5, N'ucanh21066@gmail.com', N'HSNoT7VG5m5DtXavXyVXvo2Gkjyhh+MkomLkRVq1QJ0=', N'BV3fOmLd8xKuyZNlSMYlu3RPf+mcGUjQQlQH8B+AyLI=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T18:33:00.000' AS DateTime), N'CLUB_MANAGER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (6, N'ducanh21066@gmail.com', N'TdImUxZrysf+nspt0lS7sy3dYPVGrLrZFROVK+qoTsE=', N'QS6oiuZh0CZdBl8qn62bpJKp5E8nsZ11gzv1GV7i9kI=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T18:34:00.000' AS DateTime), N'CLUB_MANAGER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (7, N'ducanh2106@gmail.com', N'sw1XzB7iLM/KQyRliQCgnIWuS8IVpiJ0MKna6ws4G2k=', N'UXClFXlEawuqFWgajEHSJDOcNtkTVxZQn744UW9yctM=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T19:03:00.000' AS DateTime), N'CLUB_MANAGER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (8, N'leagueManager@gmail.com', N'VrgBRXxtcHzQODRt1OOTAHkvmx185wkTmUXsAhucISI=', N'fZCgMhVSWNuYTqH3JGg8EqyfWYgEJfrkxj5oh6Uvp54=', N'League Mana', N'09123456', N'abcdef', 1, CAST(N'2023-02-05T23:12:00.000' AS DateTime), N'LEAGUE_MANAGER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (9, N'club@gmail.com', N'8woQMx1PdxjHjT103gtw7EdRloX3pLi/GNg7cXhhvlE=', N'EMWf6XzHQyVGaEcwxmpaXyefHZazDI0uqnzCINjIDR4=', N'Club Manager', N'0123456789', N'ABC', 1, CAST(N'2023-02-15T23:46:00.000' AS DateTime), N'CLUB_MANAGER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (10, N'league@gmail.com', N'02Rl9PDFQmkizYkYBp0yUo0K8w4DGRBadVfXbR+Hf1o=', N'2uuRrJQ5KBrpsgG9G+TpWYpELgrHU7axkKmsC2Uk+m4=', N'League Manager', N'1234567890', N'abcd', 1, CAST(N'2023-02-17T16:06:31.520' AS DateTime), N'LEAGUE_MANAGER')
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role]) VALUES (11, N'test@gmail.com', N'1DICDuOJW+c7Hdrt1xJNHRbq9rZr7NngbsyIfxRIsUQ=', N'5uiSlypZX6Yo0vdVrM2Kf1XnghPh49DcQ3++Q4PuvSA=', N'Test', N'12345678', N'abcd', 1, CAST(N'2023-02-17T16:58:14.880' AS DateTime), N'CLUB_MANAGER')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[ClubClone]  WITH CHECK ADD  CONSTRAINT [FK_ClubClone_Club] FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubClone] CHECK CONSTRAINT [FK_ClubClone_Club]
GO
ALTER TABLE [dbo].[ClubClone]  WITH CHECK ADD  CONSTRAINT [FK_ClubClone_League] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[ClubClone] CHECK CONSTRAINT [FK_ClubClone_League]
GO
ALTER TABLE [dbo].[ClubLeague]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD  CONSTRAINT [FK__League__UserId__3D5E1FD2] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[League] CHECK CONSTRAINT [FK__League__UserId__3D5E1FD2]
GO
ALTER TABLE [dbo].[LeagueFee]  WITH CHECK ADD  CONSTRAINT [FK__LeagueFee__Leagu__3E52440B] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[LeagueFee] CHECK CONSTRAINT [FK__LeagueFee__Leagu__3E52440B]
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK__Match__LeagueId__44FF419A] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK__Match__LeagueId__44FF419A]
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_ParticipateNode] FOREIGN KEY([HomeId])
REFERENCES [dbo].[ParticipateNode] ([ParticipateNodeId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_ParticipateNode]
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_ParticipateNode1] FOREIGN KEY([AwayId])
REFERENCES [dbo].[ParticipateNode] ([ParticipateNodeId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_ParticipateNode1]
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD FOREIGN KEY([MainId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD  CONSTRAINT [FK__MatchEven__Match__4CA06362] FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchEvent] CHECK CONSTRAINT [FK__MatchEven__Match__4CA06362]
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD FOREIGN KEY([SupportId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[MatchStat]  WITH CHECK ADD  CONSTRAINT [FK__MatchStat__Match__47DBAE45] FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchStat] CHECK CONSTRAINT [FK__MatchStat__Match__47DBAE45]
GO
ALTER TABLE [dbo].[ParticipateNode]  WITH CHECK ADD  CONSTRAINT [FK_ParticipateNode_ClubClone] FOREIGN KEY([ClubCloneId])
REFERENCES [dbo].[ClubClone] ([ClubCloneId])
GO
ALTER TABLE [dbo].[ParticipateNode] CHECK CONSTRAINT [FK_ParticipateNode_ClubClone]
GO
ALTER TABLE [dbo].[ParticipateNode]  WITH CHECK ADD  CONSTRAINT [FK_ParticipateNode_League] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[ParticipateNode] CHECK CONSTRAINT [FK_ParticipateNode_League]
GO
ALTER TABLE [dbo].[ParticipateRequest]  WITH CHECK ADD  CONSTRAINT [FK__Request__ClubId__5165187F] FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ParticipateRequest] CHECK CONSTRAINT [FK__Request__ClubId__5165187F]
GO
ALTER TABLE [dbo].[ParticipateRequest]  WITH CHECK ADD  CONSTRAINT [FK__Request__LeagueI__48CFD27E] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[ParticipateRequest] CHECK CONSTRAINT [FK__Request__LeagueI__48CFD27E]
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD  CONSTRAINT [FK__Participa__ClubI__4CA06362] FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Participation] CHECK CONSTRAINT [FK__Participa__ClubI__4CA06362]
GO
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD  CONSTRAINT [FK__Participa__Leagu__412EB0B6] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Participation] CHECK CONSTRAINT [FK__Participa__Leagu__412EB0B6]
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD  CONSTRAINT [FK__PlayerClu__ClubI__440B1D61] FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[PlayerClub] CHECK CONSTRAINT [FK__PlayerClu__ClubI__440B1D61]
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD  CONSTRAINT [FK__PlayerClu__Playe__4316F928] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub] CHECK CONSTRAINT [FK__PlayerClu__Playe__4316F928]
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD CHECK  (([EventType]='RedCard' OR [EventType]='YellowCard' OR [EventType]='Goal'))
GO
ALTER TABLE [dbo].[ParticipateRequest]  WITH CHECK ADD  CONSTRAINT [CK__Request__Request__5441852A] CHECK  (([RequestType]='Register' OR [RequestType]='Invite'))
GO
ALTER TABLE [dbo].[ParticipateRequest] CHECK CONSTRAINT [CK__Request__Request__5441852A]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([Role]='CLUB_MANAGER' OR [Role]='LEAGUE_MANAGER'))
GO
USE [master]
GO
ALTER DATABASE [FLMS_DB] SET  READ_WRITE 
GO
