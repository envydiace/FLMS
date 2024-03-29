USE [master]
GO
/****** Object:  Database [FLMS_DB]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[Club]    Script Date: 2/25/2023 10:40:30 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[ClubId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClubClone]    Script Date: 2/25/2023 10:40:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClubClone](
	[ClubCloneId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NULL,
	[ClubCloneKey] [nchar](10) NULL,
 CONSTRAINT [PK_ClubClone] PRIMARY KEY CLUSTERED 
(
	[ClubCloneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClubLeague]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[League]    Script Date: 2/25/2023 10:40:30 PM ******/
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
 CONSTRAINT [PK__League__10ABBCF4E505BDC3] PRIMARY KEY CLUSTERED 
(
	[LeagueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeagueFee]    Script Date: 2/25/2023 10:40:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeagueFee](
	[LeagueFeeId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ExpenseKey] [nvarchar](10) NOT NULL,
	[ExpenseName] [nvarchar](50) NOT NULL,
	[Cost] [float] NOT NULL,
	[IsActual] [bit] NOT NULL,
 CONSTRAINT [PK__LeagueFe__3502577D95B2FF37] PRIMARY KEY CLUSTERED 
(
	[LeagueFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Match]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[MatchEvent]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[MatchStat]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[ParticipateNode]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[Participation]    Script Date: 2/25/2023 10:40:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participation](
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 2/25/2023 10:40:30 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerClub]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[Request]    Script Date: 2/25/2023 10:40:30 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 2/25/2023 10:40:30 PM ******/
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

INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt]) VALUES (1, 9, N'club test', N'abc', N'test', N'test', CAST(N'2023-02-17T15:47:17.953' AS DateTime))
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt]) VALUES (2, 9, N'Club 2', N'club1@gmail.com', N'0912345678', N'abcdef', CAST(N'2023-02-17T15:50:58.820' AS DateTime))
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt]) VALUES (3, 9, N'Club 3', N'club1@gmail.com', N'0912345678', N'abcdef', CAST(N'2023-02-17T16:04:48.077' AS DateTime))
SET IDENTITY_INSERT [dbo].[Club] OFF
GO
SET IDENTITY_INSERT [dbo].[ClubClone] ON 

INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (1, 1, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (2, 1, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (3, 1, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (10, 4, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (11, 4, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (12, 4, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (18, 10, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (19, 10, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (20, 10, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (21, 11, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (22, 11, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (23, 11, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (24, 11, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (25, 11, NULL, N'C5        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (26, 12, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (27, 12, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (28, 12, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (29, 13, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (30, 13, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (31, 13, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (32, 13, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (33, 14, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (34, 14, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (35, 15, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (36, 15, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (37, 15, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (38, 15, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (39, 15, NULL, N'C5        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (40, 15, NULL, N'C6        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (41, 15, NULL, N'C7        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (42, 16, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (43, 16, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (44, 16, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (45, 16, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (46, 16, NULL, N'C5        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (47, 16, NULL, N'C6        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (48, 16, NULL, N'C7        ')
SET IDENTITY_INSERT [dbo].[ClubClone] OFF
GO
SET IDENTITY_INSERT [dbo].[League] ON 

INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (1, 10, N'a1', 3, CAST(N'2023-02-24T08:31:30.503' AS DateTime), CAST(N'2023-02-25T08:31:30.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-24T15:54:42.417' AS DateTime), NULL, N'KO', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (4, 10, N'a2', 3, CAST(N'2023-02-24T08:31:30.503' AS DateTime), CAST(N'2023-02-25T08:31:30.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-24T16:03:02.270' AS DateTime), NULL, N'KO', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (10, 10, N'a3', 3, CAST(N'2023-02-24T08:31:30.503' AS DateTime), CAST(N'2023-02-25T08:31:30.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-24T21:55:45.460' AS DateTime), NULL, N'KO', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (11, 10, N'a4', 5, CAST(N'2023-02-24T08:31:30.503' AS DateTime), CAST(N'2023-02-25T08:31:30.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-24T22:02:17.283' AS DateTime), NULL, N'KO', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (12, 10, N'a5', 3, CAST(N'2023-02-24T08:31:30.503' AS DateTime), CAST(N'2023-02-25T08:31:30.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-24T22:09:38.983' AS DateTime), NULL, N'KO', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (13, 10, N'a6', 4, CAST(N'2023-02-24T08:31:30.503' AS DateTime), CAST(N'2023-02-25T08:31:30.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-24T22:14:14.147' AS DateTime), NULL, N'KO', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (14, 10, N'a7', 2, CAST(N'2023-02-24T08:31:30.503' AS DateTime), CAST(N'2023-02-25T08:31:30.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-24T22:18:03.767' AS DateTime), NULL, N'KO', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (15, 10, N'a9', 7, CAST(N'2023-02-25T14:47:02.130' AS DateTime), CAST(N'2023-02-26T14:47:02.130' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-25T22:08:51.147' AS DateTime), NULL, N'KO', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (16, 10, N'a10', 7, CAST(N'2023-02-25T14:47:02.130' AS DateTime), CAST(N'2023-02-26T14:47:02.130' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-25T22:13:02.260' AS DateTime), NULL, N'KO', 0)
SET IDENTITY_INSERT [dbo].[League] OFF
GO
SET IDENTITY_INSERT [dbo].[LeagueFee] ON 

INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (1, 1, N'string', N'string', 0, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (4, 4, N'string', N'string', 0, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (5, 10, N'string', N'string', 0, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (6, 11, N'string', N'string', 0, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (7, 12, N'string', N'string', 0, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (8, 13, N'string', N'string', 0, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (9, 14, N'string', N'string', 0, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (10, 15, N'string', N'string', 0, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (11, 16, N'string', N'string', 0, 0)
SET IDENTITY_INSERT [dbo].[LeagueFee] OFF
GO
SET IDENTITY_INSERT [dbo].[Match] ON 

INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (1, 15, 38, 37, CAST(N'2023-02-25T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (2, 15, 40, 39, CAST(N'2023-02-25T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (3, 15, 41, 43, CAST(N'2023-02-25T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (4, 15, 45, 44, CAST(N'2023-02-25T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (5, 15, 47, 46, CAST(N'2023-02-25T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (6, 15, 49, 48, CAST(N'2023-02-25T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (7, 16, 51, 50, CAST(N'2023-02-26T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (8, 16, 53, 52, CAST(N'2023-02-25T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (9, 16, 54, 56, CAST(N'2023-02-25T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (10, 16, 58, 57, CAST(N'2023-02-24T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (11, 16, 60, 59, CAST(N'2023-02-24T14:47:02.130' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (12, 16, 62, 61, CAST(N'2023-02-24T14:47:02.130' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Match] OFF
GO
SET IDENTITY_INSERT [dbo].[ParticipateNode] ON 

INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (3, 1, NULL, 1, 0, 2, 3, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (4, 2, NULL, 2, 1, 4, 5, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (5, 3, NULL, 2, 1, 0, 0, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (6, 4, NULL, 3, 2, 0, 0, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (7, 5, NULL, 3, 2, 0, 0, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (8, 1, NULL, 1, 0, 2, 3, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (9, 2, NULL, 2, 1, 4, 5, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (10, 3, NULL, 2, 1, 0, 0, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (11, 4, NULL, 3, 2, 0, 0, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (12, 5, NULL, 3, 2, 0, 0, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (13, 1, NULL, 1, 0, 2, 3, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (14, 2, NULL, 2, 1, 4, 5, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (15, 3, NULL, 2, 1, 6, 7, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (16, 4, NULL, 3, 2, 8, 9, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (17, 5, NULL, 3, 2, 0, 0, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (18, 6, NULL, 3, 3, 0, 0, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (19, 7, NULL, 3, 3, 0, 0, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (20, 8, NULL, 4, 4, 0, 0, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (21, 9, NULL, 4, 4, 0, 0, 11)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (22, 1, NULL, 1, 0, 2, 3, 12)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (23, 2, NULL, 2, 1, 4, 5, 12)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (24, 3, 26, 2, 1, 0, 0, 12)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (25, 4, 27, 3, 2, 0, 0, 12)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (26, 5, 28, 3, 2, 0, 0, 12)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (27, 1, NULL, 1, 0, 2, 3, 13)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (28, 2, NULL, 2, 1, 4, 5, 13)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (29, 3, NULL, 2, 1, 6, 7, 13)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (30, 4, 29, 3, 2, 0, 0, 13)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (31, 5, 30, 3, 2, 0, 0, 13)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (32, 6, 31, 3, 3, 0, 0, 13)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (33, 7, 32, 3, 3, 0, 0, 13)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (34, 1, NULL, 1, 0, 2, 3, 14)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (35, 2, 33, 2, 1, 0, 0, 14)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (36, 3, 34, 2, 1, 0, 0, 14)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (37, 3, NULL, 2, 1, 6, 7, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (38, 2, NULL, 2, 1, 4, 5, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (39, 5, NULL, 3, 2, 10, 11, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (40, 4, NULL, 3, 2, 8, 9, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (41, 6, NULL, 3, 3, 12, 13, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (42, 1, NULL, 1, 0, 2, 3, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (43, 7, 35, 3, 3, 0, 0, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (44, 9, 37, 4, 4, 0, 0, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (45, 8, 36, 4, 4, 0, 0, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (46, 11, 39, 4, 5, 0, 0, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (47, 10, 38, 4, 5, 0, 0, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (48, 13, 41, 4, 6, 0, 0, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (49, 12, 40, 4, 6, 0, 0, 15)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (50, 3, NULL, 2, 1, 6, 7, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (51, 2, NULL, 2, 1, 4, 5, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (52, 5, NULL, 3, 2, 10, 11, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (53, 4, NULL, 3, 2, 8, 9, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (54, 6, NULL, 3, 3, 12, 13, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (55, 1, NULL, 1, 0, 2, 3, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (56, 7, 42, 3, 3, 0, 0, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (57, 9, 44, 4, 4, 0, 0, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (58, 8, 43, 4, 4, 0, 0, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (59, 11, 46, 4, 5, 0, 0, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (60, 10, 45, 4, 5, 0, 0, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (61, 13, 48, 4, 6, 0, 0, 16)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (62, 12, 47, 4, 6, 0, 0, 16)
SET IDENTITY_INSERT [dbo].[ParticipateNode] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshToken] ON 

INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (25, 7, N'gqozd1zJJMWsAB8KYFw0OK/gJPprPUIVdSQCEtocp3c=', N'3C4yiSJn09FOhmTbfj9iTydK2WGUgW7RiFAs+JxD/+4=', CAST(N'2023-02-03T21:24:00' AS SmallDateTime), CAST(N'2023-02-03T21:25:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (27, 8, N'o51/t8SukSEO0ziGTaZrlpRisSHbkvXRR7nnyUUHR7U=', N'lJJO9etrl5uaNj3YzwpK26NL1zphTlaax5UccFCdrSA=', CAST(N'2023-02-05T23:17:00' AS SmallDateTime), CAST(N'2023-02-05T23:18:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (52, 4, N'VqNGVkfMV35zYOl0dpMndhxTh3OX2R0Dg1bQ3bLKEbU=', N'agrHMqLT44+cUdlwGVhKa4gMSZI1D7lQNar1er2QxRA=', CAST(N'2023-02-18T22:32:00' AS SmallDateTime), CAST(N'2023-02-18T22:33:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (57, 9, N'YQXFrhT0wl9riS80+zf62ZcPBrFpVykZZUoTxI8REVg=', N'gByXnaL6UthN21F19bnIHZPvB5mQyocpSzQL1rPzkw8=', CAST(N'2023-02-21T15:38:00' AS SmallDateTime), CAST(N'2023-02-21T15:39:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (84, 10, N'qU2H7O472YzjUVl8XJrUwZ9M1nWYAljMvcdPvZL8KqM=', N'I0OZyfX3s6+Zbxn5GPnhMky0/PqDb7XwGUSIX7EcXR0=', CAST(N'2023-02-25T21:46:00' AS SmallDateTime), CAST(N'2023-02-25T21:47:00' AS SmallDateTime))
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
ALTER TABLE [dbo].[Participation]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
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
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK__Request__LeagueI__48CFD27E] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK__Request__LeagueI__48CFD27E]
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD CHECK  (([EventType]='RedCard' OR [EventType]='YellowCard' OR [EventType]='Goal'))
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD CHECK  (([RequestType]='Register' OR [RequestType]='Invite'))
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([Role]='CLUB_MANAGER' OR [Role]='LEAGUE_MANAGER'))
GO
USE [master]
GO
ALTER DATABASE [FLMS_DB] SET  READ_WRITE 
GO
