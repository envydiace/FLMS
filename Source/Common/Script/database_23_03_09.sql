USE [master]
GO
/****** Object:  Database [FLMS_DB]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[Club]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[ClubClone]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[League]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[LeagueFee]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[Match]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[MatchEvent]    Script Date: 3/9/2023 9:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchEvent](
	[MatchEventId] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NOT NULL,
	[SubId] [int] NULL,
	[MatchId] [int] NOT NULL,
	[EventType] [nvarchar](50) NOT NULL,
	[EventTime] [int] NOT NULL,
	[IsHome] [bit] NOT NULL,
 CONSTRAINT [PK_MatchEvent] PRIMARY KEY CLUSTERED 
(
	[MatchEventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatchStat]    Script Date: 3/9/2023 9:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchStat](
	[MatchStatId] [int] IDENTITY(1,1) NOT NULL,
	[MatchId] [int] NOT NULL,
	[IsHome] [bit] NOT NULL,
	[Shot] [int] NOT NULL,
	[ShotOnTarget] [int] NOT NULL,
	[Conner] [int] NOT NULL,
	[Foul] [int] NOT NULL,
	[Offside] [int] NOT NULL,
	[YellowCard] [int] NOT NULL,
	[RedCard] [int] NOT NULL,
 CONSTRAINT [PK__MatchSta__217B5447287A9B9B] PRIMARY KEY CLUSTERED 
(
	[MatchStatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParticipateNode]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[ParticipateRequest]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[Participation]    Script Date: 3/9/2023 9:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participation](
	[ParticipationId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
	[Confirmed] [bit] NOT NULL,
	[evidence] [nvarchar](max) NULL,
 CONSTRAINT [PK_Participation] PRIMARY KEY CLUSTERED 
(
	[ParticipationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[PlayerClub]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 3/9/2023 9:32:39 AM ******/
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
/****** Object:  Table [dbo].[Squad]    Script Date: 3/9/2023 9:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Squad](
	[SquadId] [int] IDENTITY(1,1) NOT NULL,
	[MatchId] [int] NOT NULL,
	[IsHome] [bit] NOT NULL,
	[NoPlayerSquad] [int] NOT NULL,
 CONSTRAINT [PK_Squad] PRIMARY KEY CLUSTERED 
(
	[SquadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SquadPosition]    Script Date: 3/9/2023 9:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SquadPosition](
	[SquadPositionId] [int] IDENTITY(1,1) NOT NULL,
	[SquadId] [int] NOT NULL,
	[PositionKey] [nvarchar](10) NOT NULL,
	[PlayerId] [int] NULL,
 CONSTRAINT [PK_SquadPosition] PRIMARY KEY CLUSTERED 
(
	[SquadPositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/9/2023 9:32:39 AM ******/
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
	[Avatar] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Club] ON 

INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (1, 9, N'club test', N'abc', N'test', N'test', CAST(N'2023-02-17T15:47:17.953' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (2, 9, N'Club 2', N'club1@gmail.com', N'0912345678', N'abcdef', CAST(N'2023-02-17T15:50:58.820' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (3, 9, N'Club 3', N'club1@gmail.com', N'0912345678', N'abcdef', CAST(N'2023-02-17T16:04:48.077' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (4, 9, N'Club A', N'ClubA@gmail.com', N'1234567890', N'abc', CAST(N'2023-02-27T20:38:36.253' AS DateTime), N'images/abc', N'images/def')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (5, 12, N'Club Xyz', N'Clubx@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:29:35.787' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (6, 12, N'Club Xyzt', N'Clubxzt@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:30:24.217' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (7, 13, N'Club ABC', N'Clubabc@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:35:13.170' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (8, 13, N'Club AYT', N'Clubayt@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:35:23.213' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (9, 13, N'Club DEF', N'Clubdef@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:35:31.063' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (10, 21, N'Manchester United', N'mu@gmail.com', N'1234', N'MU', CAST(N'2023-03-02T21:48:06.700' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (11, 18, N'Manchester City', N'mc@gmail.com', N'1234', N'MC', CAST(N'2023-03-02T22:14:07.963' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (12, 19, N'Real Madrid', N'rm@gmail.com', N'1234', N'RM', CAST(N'2023-03-02T22:14:52.923' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (13, 22, N'Barcelona', N'barca@gmail.com', N'1234', N'Barca', CAST(N'2023-03-02T22:48:02.017' AS DateTime), N'', N'')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (14, 22, N'Khong biet', N'khongbiet@gmail.com', N'0912345678', N'NMV', CAST(N'2023-03-04T21:44:02.593' AS DateTime), N'', N'')
SET IDENTITY_INSERT [dbo].[Club] OFF
GO
SET IDENTITY_INSERT [dbo].[ClubClone] ON 

INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (1, 1, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (2, 1, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (3, 1, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (4, 1, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (5, 1, NULL, N'C5        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (6, 2, 3, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (7, 2, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (8, 2, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (9, 2, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (10, 2, NULL, N'C5        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (11, 2, NULL, N'C6        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (12, 2, NULL, N'C7        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (13, 3, 13, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (14, 3, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (15, 3, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (16, 3, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (17, 3, NULL, N'C5        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (18, 3, NULL, N'C6        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (19, 3, NULL, N'C7        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (20, 4, 3, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (21, 4, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (22, 4, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (23, 4, NULL, N'C4        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (24, 5, NULL, N'C1        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (25, 5, NULL, N'C2        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (26, 5, NULL, N'C3        ')
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey]) VALUES (27, 5, NULL, N'C4        ')
SET IDENTITY_INSERT [dbo].[ClubClone] OFF
GO
SET IDENTITY_INSERT [dbo].[League] ON 

INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo]) VALUES (1, 10, N'League Knock-out 5 team', 5, CAST(N'2023-02-28T17:00:00.000' AS DateTime), CAST(N'2023-03-15T17:00:00.000' AS DateTime), 20, 11, N'Hoa Lac', N'fuhoalac', CAST(N'2023-02-26T15:25:50.800' AS DateTime), NULL, N'KO', 1, NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo]) VALUES (2, 10, N'League Round table 7 team', 7, CAST(N'2023-02-28T17:00:00.000' AS DateTime), CAST(N'2023-03-15T17:00:00.000' AS DateTime), 20, 11, N'FPT Hoa Lac', N'fuhoalac', CAST(N'2023-02-26T15:29:10.363' AS DateTime), NULL, N'LEAGUE', 1, NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo]) VALUES (3, 4, N'Super League 2023', 7, CAST(N'2023-03-02T15:28:03.087' AS DateTime), CAST(N'2023-03-04T15:28:03.087' AS DateTime), 20, 11, N'FPT', N'superleague', CAST(N'2023-03-02T22:32:26.163' AS DateTime), N'The super league in 2023', N'LEAGUE', 1, NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo]) VALUES (4, 4, N'Test League 5 squad max 15', 4, CAST(N'2023-03-07T04:09:28.677' AS DateTime), CAST(N'2023-03-08T04:09:28.677' AS DateTime), 15, 5, N'FU', N'abc', CAST(N'2023-03-07T11:11:03.053' AS DateTime), N'string', N'LEAGUE', 1, NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo]) VALUES (5, 4, N'Test K.O 7 squad max 12', 4, CAST(N'2023-03-07T04:09:28.677' AS DateTime), CAST(N'2023-03-08T04:09:28.677' AS DateTime), 12, 7, N'FU', N'abc', CAST(N'2023-03-07T11:13:42.507' AS DateTime), N'string', N'KO', 1, NULL)
SET IDENTITY_INSERT [dbo].[League] OFF
GO
SET IDENTITY_INSERT [dbo].[LeagueFee] ON 

INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (1, 1, N'A', N'Gold Medal', 50000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (2, 1, N'B', N'Silver Medal', 25000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (3, 1, N'C', N'Bronze Medal', 15000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (4, 2, N'A', N'Gold Medal', 20000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (5, 2, N'B', N'Silver Medal', 10000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (6, 2, N'C', N'Bronze Medal', 5000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (7, 3, N'K0', N'Gold Medal', 5000000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (8, 3, N'K1', N'Silver Medal', 2500000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (9, 3, N'K2', N'Bronze Medal', 1000000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (10, 3, N'K3', N'Top Score', 200000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (11, 3, N'K4', N'Top assist', 200000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (12, 3, N'K5', N'Best Goal Keeper', 200000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (13, 3, N'K6', N'Field Fee', 300000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (14, 3, N'K7', N'Referee', 400000.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (15, 4, N'string', N'string', 0.0000, 0)
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (16, 5, N'string', N'string', 0.0000, 0)
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
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (26, 3, 18, 17, CAST(N'2023-03-02T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (27, 3, 20, 19, CAST(N'2023-03-02T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (28, 3, 22, 21, CAST(N'2023-03-02T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (29, 3, 23, 17, CAST(N'2023-03-04T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (30, 3, 20, 18, CAST(N'2023-03-04T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (31, 3, 21, 19, CAST(N'2023-03-04T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (32, 3, 20, 17, CAST(N'2023-03-06T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (33, 3, 22, 23, CAST(N'2023-03-06T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (34, 3, 21, 18, CAST(N'2023-03-06T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (35, 3, 22, 17, CAST(N'2023-03-08T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (36, 3, 21, 20, CAST(N'2023-03-08T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (37, 3, 19, 23, CAST(N'2023-03-08T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (38, 3, 21, 17, CAST(N'2023-03-10T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (39, 3, 19, 22, CAST(N'2023-03-10T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (40, 3, 18, 23, CAST(N'2023-03-10T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (41, 3, 19, 17, CAST(N'2023-03-12T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (42, 3, 18, 22, CAST(N'2023-03-12T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (43, 3, 23, 20, CAST(N'2023-03-12T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (44, 3, 18, 19, CAST(N'2023-03-14T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (45, 3, 23, 21, CAST(N'2023-03-14T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (46, 3, 20, 22, CAST(N'2023-03-14T15:28:03.087' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (47, 4, 25, 24, CAST(N'2023-03-07T04:09:28.677' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (48, 4, 27, 26, CAST(N'2023-03-07T04:09:28.677' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (49, 4, 27, 24, CAST(N'2023-03-09T04:09:28.677' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (50, 4, 26, 25, CAST(N'2023-03-09T04:09:28.677' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (51, 4, 26, 24, CAST(N'2023-03-11T04:09:28.677' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (52, 4, 25, 27, CAST(N'2023-03-11T04:09:28.677' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (53, 5, 29, 28, CAST(N'2023-03-08T04:09:28.677' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (54, 5, 32, 31, CAST(N'2023-03-06T04:09:28.677' AS DateTime), 0)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish]) VALUES (55, 5, 34, 33, CAST(N'2023-03-06T04:09:28.677' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Match] OFF
GO
SET IDENTITY_INSERT [dbo].[MatchEvent] ON 

INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (1, 2, NULL, 47, N'Goal', 2, 0)
SET IDENTITY_INSERT [dbo].[MatchEvent] OFF
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
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (17, 0, 13, 0, NULL, NULL, NULL, 3)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (18, 0, 14, 0, NULL, NULL, NULL, 3)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (19, 0, 19, 0, NULL, NULL, NULL, 3)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (20, 0, 16, 0, NULL, NULL, NULL, 3)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (21, 0, 18, 0, NULL, NULL, NULL, 3)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (22, 0, 17, 0, NULL, NULL, NULL, 3)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (23, 0, 15, 0, NULL, NULL, NULL, 3)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (24, 0, 20, 0, NULL, NULL, NULL, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (25, 0, 21, 0, NULL, NULL, NULL, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (26, 0, 23, 0, NULL, NULL, NULL, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (27, 0, 22, 0, NULL, NULL, NULL, 4)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (28, 3, NULL, 2, 1, 6, 7, 5)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (29, 2, NULL, 2, 1, 4, 5, 5)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (30, 1, NULL, 1, 0, 2, 3, 5)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (31, 5, 25, 3, 2, 0, 0, 5)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (32, 4, 24, 3, 2, 0, 0, 5)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (33, 7, 27, 3, 3, 0, 0, 5)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (34, 6, 26, 3, 3, 0, 0, 5)
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
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (14, 3, 12, N'Invite', N'Accepted', CAST(N'2023-03-02T22:36:32.733' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (15, 3, 11, N'Invite', N'Accepted', CAST(N'2023-03-02T22:36:42.840' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (16, 3, 10, N'Invite', N'Rejected', CAST(N'2023-03-02T22:36:47.383' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (17, 3, 9, N'Invite', N'Pending', CAST(N'2023-03-02T22:36:50.133' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (18, 3, 8, N'Invite', N'Pending', CAST(N'2023-03-02T22:37:13.033' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (19, 3, 7, N'Invite', N'Pending', CAST(N'2023-03-02T22:37:15.320' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (20, 3, 6, N'Invite', N'Pending', CAST(N'2023-03-02T22:37:17.557' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (21, 3, 4, N'Invite', N'Canceled', CAST(N'2023-03-02T22:37:20.007' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (22, 3, 13, N'Register', N'Accepted', CAST(N'2023-03-02T22:48:40.933' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (23, 3, 1, N'Invite', N'Pending', CAST(N'2023-03-05T22:32:59.707' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (24, 3, 14, N'Register', N'Canceled', CAST(N'2023-03-06T10:30:40.940' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (25, 1, 14, N'Register', N'Canceled', CAST(N'2023-03-06T12:23:20.640' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (26, 3, 2, N'Invite', N'Pending', CAST(N'2023-03-06T12:27:59.143' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (27, 1, 10, N'Register', N'Pending', CAST(N'2023-03-06T15:53:34.280' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (28, 3, 10, N'Register', N'Accepted', CAST(N'2023-03-06T15:56:52.630' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (29, 4, 3, N'Invite', N'Accepted', CAST(N'2023-03-07T15:33:36.453' AS DateTime))
SET IDENTITY_INSERT [dbo].[ParticipateRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[Participation] ON 

INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (1, 1, 3, 0, NULL)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (2, 1, 4, 0, NULL)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (3, 2, 2, 0, NULL)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (4, 2, 3, 1, N'string')
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (5, 3, 13, 1, N'evidence')
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (6, 3, 11, 0, NULL)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (7, 3, 12, 0, NULL)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (8, 3, 10, 0, NULL)
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence]) VALUES (9, 4, 3, 1, N'string')
SET IDENTITY_INSERT [dbo].[Participation] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (2, N'Player 1', N'anh', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (3, N'Player 2', N'anh2', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (4, N'Ninh Duc Anh', N'ninhkhoai07', CAST(N'2001-06-20T17:00:00.000' AS DateTime), N'1m72', N'63kg', N'Long Bien', N'ninhducanh', N'ducanh2106@gmail.com', N'anhnd', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (5, N'Messiii', N'mes', CAST(N'2017-02-06T17:00:00.000' AS DateTime), N'1m69', N'70kg', N'Spain', N'aaaa', N'messi@gmail.com', N'messsiiii', NULL)
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
SET IDENTITY_INSERT [dbo].[PlayerClub] ON 

INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (1, 2, 4, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (2, 2, 3, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (3, 3, 3, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (4, 4, 14, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (5, 5, 13, 10)
SET IDENTITY_INSERT [dbo].[PlayerClub] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshToken] ON 

INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (25, 7, N'gqozd1zJJMWsAB8KYFw0OK/gJPprPUIVdSQCEtocp3c=', N'3C4yiSJn09FOhmTbfj9iTydK2WGUgW7RiFAs+JxD/+4=', CAST(N'2023-02-03T21:24:00' AS SmallDateTime), CAST(N'2023-02-03T21:25:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (27, 8, N'o51/t8SukSEO0ziGTaZrlpRisSHbkvXRR7nnyUUHR7U=', N'lJJO9etrl5uaNj3YzwpK26NL1zphTlaax5UccFCdrSA=', CAST(N'2023-02-05T23:17:00' AS SmallDateTime), CAST(N'2023-02-05T23:18:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (97, 11, N'v9QEfKDz6kmFRoDrR2QTyhQppE5uS9VITfG3AMIssMA=', N'hfyuiM7DmP9DAZX851Jp4GiAeTVjILlC0EOlh2Gb8iI=', CAST(N'2023-03-01T10:11:00' AS SmallDateTime), CAST(N'2023-03-01T10:12:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (113, 17, N'RIEnyyq11vkEoZ4DGR0ukGJauPjpGEoy4Z6Zo5tmiO4=', N'L2LZO2SLTH8TGGc2/kUGtGln4ezZ3HVDfwvtu2xwSd0=', CAST(N'2023-03-02T21:47:00' AS SmallDateTime), CAST(N'2023-03-02T21:48:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (117, 20, N'k8O+OhhA5h+yVG2L7OXZ50tZDWIaOb/vSp01CyIZGxA=', N'VSgu4Pbj4TOnwu7Z3iIm6mBVGaaWTjlUBzJo5w5KPBc=', CAST(N'2023-03-02T22:16:00' AS SmallDateTime), CAST(N'2023-03-02T22:17:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (123, 18, N'SR9PbuWNTPIAsRHCw1PeUBtDeLUFdX4mmSKnaFn0Ozk=', N'IjaIPOxsn54sGhaXTKYxoQWDlln1zsfmw3eOwEgAdNU=', CAST(N'2023-03-02T23:09:00' AS SmallDateTime), CAST(N'2023-03-02T23:10:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (124, 19, N'FQFKnUxBdhHdMFjxQ1HXkFiLoLsTBRd5Y4IEBv8W5TI=', N'S3riLc7MGAm0BXK03K7zJLr8uINjb1c8ZlcDyLhIVsk=', CAST(N'2023-03-02T23:09:00' AS SmallDateTime), CAST(N'2023-03-02T23:10:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (131, 13, N'LQduzcfTWMsLEaADv6yCqFZ+iDCdPcYTLhn8CU9MCYg=', N'c4d0pmb2BhsRAkMV3Cx/CTltFCLqdlB1jrt/Ihvs9oM=', CAST(N'2023-03-04T08:51:00' AS SmallDateTime), CAST(N'2023-03-04T08:52:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (134, 10, N'YALJnkbpxB0YwnlQWzMp3IivSkAVVcCl+uq3BpmDc+s=', N'z1pTyjzQFOlwPL4mcWPuEmmyTStD/569E02Pz7AYNBE=', CAST(N'2023-03-04T09:21:00' AS SmallDateTime), CAST(N'2023-03-04T09:22:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (155, 23, N'4PvphZoRMmFzHatncYDNTECGASMNwvzaGHpJFy1msA0=', N'8f7lHJQt+LmjZRZ/rxKMlYVngeE5y+G4QAg0wFG7QfI=', CAST(N'2023-03-07T13:56:00' AS SmallDateTime), CAST(N'2023-03-07T13:57:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (159, 21, N'N7puAuw8FUYoLpLHiGZslPukwoSpOKkB7exzbVnij+Y=', N'55vPiLpGLkRRTedgIAY8eofXJwCJ4VxiX51A1ghgyec=', CAST(N'2023-03-07T18:00:00' AS SmallDateTime), CAST(N'2023-03-07T18:01:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (161, 12, N'eP8EoSU1UjaRcy705C+kxSiFmBodKO4+azdd/bJ6KyM=', N'bHqGHZQS/4Qk0MPXEmz7+BWeRPFip1euiIUmSqvdKFI=', CAST(N'2023-03-07T18:04:00' AS SmallDateTime), CAST(N'2023-03-07T18:05:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (162, 9, N'hd8aorvT5Yag0Plh0X1U8iaZzTp3QvR2xHuJ/7ITrWI=', N'Gbcd8fc6xzDoAO3HzvlCthSgJD5htOB1905XBgS/Lng=', CAST(N'2023-03-07T18:10:00' AS SmallDateTime), CAST(N'2023-03-07T18:11:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (165, 4, N'SZK+jaQX618LhEnMhhVbyFd+p9qllnrLSCFp1TMwTz4=', N'DKEKhqKLlMmzXdOmieyK6nX/v/ZJ+FN1BR+T/2FrgJM=', CAST(N'2023-03-08T17:15:00' AS SmallDateTime), CAST(N'2023-03-08T17:16:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[RefreshToken] OFF
GO
SET IDENTITY_INSERT [dbo].[Squad] ON 

INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (1, 47, 1, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (2, 47, 0, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (3, 48, 1, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (4, 48, 0, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (5, 49, 1, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (6, 49, 0, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (7, 50, 1, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (8, 50, 0, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (9, 51, 1, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (10, 51, 0, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (11, 52, 1, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (12, 52, 0, 5)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (13, 53, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (14, 53, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (15, 54, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (16, 54, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (17, 55, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (18, 55, 0, 7)
SET IDENTITY_INSERT [dbo].[Squad] OFF
GO
SET IDENTITY_INSERT [dbo].[SquadPosition] ON 

INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1, 1, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (2, 1, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (3, 1, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (4, 1, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (5, 1, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (6, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (7, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (8, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (9, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (10, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (11, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (12, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (13, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (14, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (15, 1, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (16, 2, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (17, 2, N'P2', 2)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (18, 2, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (19, 2, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (20, 2, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (21, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (22, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (23, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (24, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (25, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (26, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (27, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (28, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (29, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (30, 2, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (31, 3, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (32, 3, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (33, 3, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (34, 3, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (35, 3, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (36, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (37, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (38, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (39, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (40, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (41, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (42, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (43, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (44, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (45, 3, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (46, 4, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (47, 4, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (48, 4, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (49, 4, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (50, 4, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (51, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (52, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (53, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (54, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (55, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (56, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (57, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (58, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (59, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (60, 4, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (61, 5, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (62, 5, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (63, 5, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (64, 5, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (65, 5, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (66, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (67, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (68, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (69, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (70, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (71, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (72, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (73, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (74, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (75, 5, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (76, 6, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (77, 6, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (78, 6, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (79, 6, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (80, 6, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (81, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (82, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (83, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (84, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (85, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (86, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (87, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (88, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (89, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (90, 6, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (91, 7, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (92, 7, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (93, 7, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (94, 7, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (95, 7, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (96, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (97, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (98, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (99, 7, N'P0', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (100, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (101, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (102, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (103, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (104, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (105, 7, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (106, 8, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (107, 8, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (108, 8, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (109, 8, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (110, 8, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (111, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (112, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (113, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (114, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (115, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (116, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (117, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (118, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (119, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (120, 8, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (121, 9, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (122, 9, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (123, 9, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (124, 9, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (125, 9, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (126, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (127, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (128, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (129, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (130, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (131, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (132, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (133, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (134, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (135, 9, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (136, 10, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (137, 10, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (138, 10, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (139, 10, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (140, 10, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (141, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (142, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (143, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (144, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (145, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (146, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (147, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (148, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (149, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (150, 10, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (151, 11, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (152, 11, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (153, 11, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (154, 11, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (155, 11, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (156, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (157, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (158, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (159, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (160, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (161, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (162, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (163, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (164, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (165, 11, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (166, 12, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (167, 12, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (168, 12, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (169, 12, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (170, 12, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (171, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (172, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (173, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (174, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (175, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (176, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (177, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (178, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (179, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (180, 12, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (181, 13, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (182, 13, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (183, 13, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (184, 13, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (185, 13, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (186, 13, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (187, 13, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (188, 13, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (189, 13, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (190, 13, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (191, 13, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (192, 13, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (193, 14, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (194, 14, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (195, 14, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (196, 14, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (197, 14, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (198, 14, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (199, 14, N'P7', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (200, 14, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (201, 14, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (202, 14, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (203, 14, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (204, 14, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (205, 15, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (206, 15, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (207, 15, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (208, 15, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (209, 15, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (210, 15, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (211, 15, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (212, 15, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (213, 15, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (214, 15, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (215, 15, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (216, 15, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (217, 16, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (218, 16, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (219, 16, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (220, 16, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (221, 16, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (222, 16, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (223, 16, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (224, 16, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (225, 16, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (226, 16, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (227, 16, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (228, 16, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (229, 17, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (230, 17, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (231, 17, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (232, 17, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (233, 17, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (234, 17, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (235, 17, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (236, 17, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (237, 17, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (238, 17, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (239, 17, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (240, 17, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (241, 18, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (242, 18, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (243, 18, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (244, 18, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (245, 18, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (246, 18, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (247, 18, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (248, 18, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (249, 18, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (250, 18, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (251, 18, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (252, 18, N'P0', NULL)
SET IDENTITY_INSERT [dbo].[SquadPosition] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (4, N'ninhkhoai2106@gmail.com', N'ja5VxAA5bb/4RRr9JfJRve+yXIBMdan0iGuU9+HGYGk=', N'58MEo0ZtKXtt6prq28aAZ3Q1f5/Eq/JlV/ghTm0B9Z8=', N'Ninh Duc Anh', N'0915936216', N'Long Bien, Ha Noi', 1, CAST(N'2023-01-21T18:32:00.000' AS DateTime), N'LEAGUE_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (7, N'ducanh2106@gmail.com', N'sw1XzB7iLM/KQyRliQCgnIWuS8IVpiJ0MKna6ws4G2k=', N'UXClFXlEawuqFWgajEHSJDOcNtkTVxZQn744UW9yctM=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T19:03:00.000' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (8, N'leagueManager@gmail.com', N'VrgBRXxtcHzQODRt1OOTAHkvmx185wkTmUXsAhucISI=', N'fZCgMhVSWNuYTqH3JGg8EqyfWYgEJfrkxj5oh6Uvp54=', N'League Mana', N'09123456', N'abcdef', 1, CAST(N'2023-02-05T23:12:00.000' AS DateTime), N'LEAGUE_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (9, N'club@gmail.com', N'rqgExFZSIG+Tv2I4g7zX30mbHC0B6bwP/UoOvQ7wDkQ=', N'EMWf6XzHQyVGaEcwxmpaXyefHZazDI0uqnzCINjIDR4=', N'Club Manager', N'0123456789', N'ABC', 1, CAST(N'2023-02-15T23:46:00.000' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (10, N'league@gmail.com', N'TAAphKR0vKo6SH87EH2N1E/9wFx4loYmjLK2bfeKCiI=', N'2uuRrJQ5KBrpsgG9G+TpWYpELgrHU7axkKmsC2Uk+m4=', N'League Manager', N'1234567890', N'abcd', 1, CAST(N'2023-02-17T16:06:31.520' AS DateTime), N'LEAGUE_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (11, N'test@gmail.com', N'1DICDuOJW+c7Hdrt1xJNHRbq9rZr7NngbsyIfxRIsUQ=', N'5uiSlypZX6Yo0vdVrM2Kf1XnghPh49DcQ3++Q4PuvSA=', N'Test', N'12345678', N'abcd', 1, CAST(N'2023-02-17T16:58:14.880' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (12, N'clubx@gmail.com', N'RlBKE4H7EJvkLlvQNMg1qw2tgRGHo+ty96RTJm5k1os=', N'VOFGRG8wK7pO5eiyxHU15iHEsdfM3kcHMifRZK5GsZk=', N'Manager X', N'0912345678', N'abcd', 1, CAST(N'2023-03-01T23:26:17.380' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (13, N'cluby@gmail.com', N'gLm1fqQnSH3T+5NzQp68GE9mEhY1SjE+Rds0hLlYiXI=', N'leDAyiURd2LVh81GLOLF1OYkomN65PAb7DxaD+4SvLc=', N'Manager Y', N'0912345678', N'abcd', 1, CAST(N'2023-03-01T23:34:36.577' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (14, N'leaguex@gmail.com', N'yOu5JU6sVuyXft9zD7BuAUr/34vw/fgWab7MSlnSDho=', N'Y/IZhV5bs+RGH2KX0S6fErufTggZJTcpMOz/o8ZKVmA=', N'Phan Anh Tung', N'1234567890', N'D203', 1, CAST(N'2023-03-02T21:39:41.493' AS DateTime), N'LEAGUE_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (15, N'leaguey@gmail.com', N'bVoH27/SgouP8hburj0W3q/koJnY9pUP5l19/fL+Mwc=', N'SzCy6DZI91F6FeoXHe+gOBeP2RG+N+Jps5KhXihv64k=', N'Nguyen Tan Phon', N'1234567890', N'Vinhome Smartcity', 1, CAST(N'2023-03-02T21:40:22.200' AS DateTime), N'LEAGUE_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (16, N'leaguez@gmail.com', N'fzzdLy83qDwL1YwDUrL8bsSxkCzXdEYIrusQZf6OqKo=', N'8UkbHI+Dq7YDRKFqAS6A7NoM6mhu9p+VXL8/qseCRfQ=', N'Nguyen Minh Son', N'1234567890', N'Fu Dom D', 1, CAST(N'2023-03-02T21:40:46.187' AS DateTime), N'LEAGUE_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (17, N'clubz@gmail.com', N'GOeXr7D+O017c0fmLrbc79eyIOg2xE85fZSB8aLangE=', N'F/JwReTlSTFHuMwfnC8pKIoGREb/doz+giIi7sIbbqo=', N'Ta Vu Minh Chau', N'1234567890', N'KTX FPT', 1, CAST(N'2023-03-02T21:41:50.800' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (18, N'cluba@gmail.com', N'wx/IgKpivVkvaJHR5PT8MXOKf9tpN6G94+wI2tCyuAc=', N'Kg8SJTCIXVIML8koC0kL+FTQNdLo15WiMczogMr9RqA=', N'Club Manager A', N'1234567890', N'FPT', 1, CAST(N'2023-03-02T22:13:03.133' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (19, N'clubb@gmail.com', N'w2bUZjziKbwzKtIj8Tw7U734h5xhFoPSw7ECdiu1xxw=', N'RwaCUV89xHEW3bliKh4Lg90ihLukAlRVkz6UZyDAhBw=', N'Club Manager B', N'1234567890', N'FPT', 1, CAST(N'2023-03-02T22:13:13.923' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (20, N'clubc@gmail.com', N'OCppUs2H1bTJKDjXKgrKNhq6GJmhW4OLClX9RQM4sOE=', N'C2skCAqwaR3A20ZU/HN+tBRCQ6HO5mEMM8k0Yj4iKvs=', N'Club Manager B', N'1234567890', N'FPT', 1, CAST(N'2023-03-02T22:13:23.473' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (21, N'anhndhe150329@fpt.edu.vn', N'SLZ2O5Tgs2GDedSoS/R0zhPAKPy0JqFEnDDh+eb2kMA=', N'Ob0yjUSswNee8L0OKhoaY6BKcsA6wUW+AZKn9eJEYdQ=', N'Anh. Ninh Duc', N'1234567890', N'Long Bien, Ha Noi', 1, CAST(N'2023-03-02T22:26:28.507' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (22, N'vunhatmai.mfc@gmail.com', N'KsThOHLx02rv2HzuLdMwS0K8i8rQ4GHILyg6jy7dzxA=', N'Pdv5E+ZuPl1iXG8F1Kc9HqPP0vdqoUX5pq6toYLSIxc=', N'Nhat Mai Vu', N'1234567890', N'Ba Dinh, Ha Noi', 1, CAST(N'2023-03-02T22:38:41.750' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (23, N'ninhducanh216@gmail.com', N'O5Ad9Eyj4ajGrvQW88IDqjDy/eNLgzv3WKjUqGF6hLk=', N'8RDEAPqVC+FETjL4wKbcMRyyGX/r9K7tT5DhUw96Q2k=', N'Ninh Duc Anh', N'0915936216', N'Thuong Thanh, Long Bien, Ha Noi', 1, CAST(N'2023-03-02T23:33:20.610' AS DateTime), N'CLUB_MANAGER', NULL)
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
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD  CONSTRAINT [FK_MatchEvent_Match] FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[MatchEvent] CHECK CONSTRAINT [FK_MatchEvent_Match]
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD  CONSTRAINT [FK_MatchEvent_Player] FOREIGN KEY([MainId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[MatchEvent] CHECK CONSTRAINT [FK_MatchEvent_Player]
GO
ALTER TABLE [dbo].[MatchEvent]  WITH CHECK ADD  CONSTRAINT [FK_MatchEvent_Player1] FOREIGN KEY([SubId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[MatchEvent] CHECK CONSTRAINT [FK_MatchEvent_Player1]
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
ALTER TABLE [dbo].[Squad]  WITH CHECK ADD  CONSTRAINT [FK_Squad_Match] FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[Squad] CHECK CONSTRAINT [FK_Squad_Match]
GO
ALTER TABLE [dbo].[SquadPosition]  WITH CHECK ADD  CONSTRAINT [FK_SquadPosition_Player] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[SquadPosition] CHECK CONSTRAINT [FK_SquadPosition_Player]
GO
ALTER TABLE [dbo].[SquadPosition]  WITH CHECK ADD  CONSTRAINT [FK_SquadPosition_Squad] FOREIGN KEY([SquadId])
REFERENCES [dbo].[Squad] ([SquadId])
GO
ALTER TABLE [dbo].[SquadPosition] CHECK CONSTRAINT [FK_SquadPosition_Squad]
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
