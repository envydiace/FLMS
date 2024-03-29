USE [master]
GO
/****** Object:  Database [FLMS_DB]    Script Date: 4/12/2023 12:25:34 AM ******/
CREATE DATABASE [FLMS_DB]

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
/****** Object:  Schema [HangFire]    Script Date: 4/12/2023 12:25:34 AM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [dbo].[Club]    Script Date: 4/12/2023 12:25:34 AM ******/
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
	[CreateAt] [datetime] NOT NULL,
	[Logo] [nvarchar](max) NULL,
	[FanPage] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClubId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClubClone]    Script Date: 4/12/2023 12:25:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClubClone](
	[ClubCloneId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NULL,
	[ClubCloneKey] [nchar](10) NOT NULL,
	[Won] [int] NOT NULL,
	[Draw] [int] NOT NULL,
	[Loss] [int] NOT NULL,
	[GoalsFor] [int] NOT NULL,
	[GoalsAgainst] [int] NOT NULL,
	[Rank] [nvarchar](50) NULL,
 CONSTRAINT [PK_ClubClone] PRIMARY KEY CLUSTERED 
(
	[ClubCloneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[League]    Script Date: 4/12/2023 12:25:34 AM ******/
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
	[Fanpage] [text] NULL,
	[CreateAt] [datetime] NOT NULL,
	[Description] [text] NULL,
	[LeagueType] [nvarchar](50) NOT NULL,
	[NoRound] [int] NULL,
	[Logo] [nvarchar](max) NULL,
	[IsFinished] [bit] NOT NULL,
 CONSTRAINT [PK__League__10ABBCF4E505BDC3] PRIMARY KEY CLUSTERED 
(
	[LeagueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeagueFee]    Script Date: 4/12/2023 12:25:34 AM ******/
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
	[FeeType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__LeagueFe__3502577D95B2FF37] PRIMARY KEY CLUSTERED 
(
	[LeagueFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Match]    Script Date: 4/12/2023 12:25:34 AM ******/
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
	[Round] [nvarchar](100) NULL,
	[Stadium] [nvarchar](100) NULL,
 CONSTRAINT [PK__Match__4218C817BFC20F75] PRIMARY KEY CLUSTERED 
(
	[MatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatchEvent]    Script Date: 4/12/2023 12:25:34 AM ******/
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
/****** Object:  Table [dbo].[MatchStat]    Script Date: 4/12/2023 12:25:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchStat](
	[MatchStatId] [int] IDENTITY(1,1) NOT NULL,
	[MatchId] [int] NOT NULL,
	[IsHome] [bit] NOT NULL,
	[Score] [int] NOT NULL,
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
/****** Object:  Table [dbo].[ParticipateNode]    Script Date: 4/12/2023 12:25:34 AM ******/
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
/****** Object:  Table [dbo].[ParticipateRequest]    Script Date: 4/12/2023 12:25:34 AM ******/
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
/****** Object:  Table [dbo].[Participation]    Script Date: 4/12/2023 12:25:34 AM ******/
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
	[JoinDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Participation] PRIMARY KEY CLUSTERED 
(
	[ParticipationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 4/12/2023 12:25:34 AM ******/
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
/****** Object:  Table [dbo].[PlayerClub]    Script Date: 4/12/2023 12:25:34 AM ******/
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
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 4/12/2023 12:25:34 AM ******/
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
/****** Object:  Table [dbo].[Squad]    Script Date: 4/12/2023 12:25:34 AM ******/
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
/****** Object:  Table [dbo].[SquadPosition]    Script Date: 4/12/2023 12:25:34 AM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 4/12/2023 12:25:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[PasswordSalt] [varchar](255) NOT NULL,
	[FullName] [varchar](50) NOT NULL,
	[Phone] [varchar](15) NULL,
	[Address] [varchar](255) NULL,
	[Active] [bit] NOT NULL,
	[CreateAt] [datetime] NOT NULL,
	[Role] [nvarchar](255) NOT NULL,
	[Avatar] [nvarchar](max) NULL,
	[ResetToken] [varchar](255) NULL,
	[TokenExpire] [datetime] NULL,
 CONSTRAINT [PK__User__1788CC4CAAE79317] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Club] ON 

INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (1, 9, N'club test', N'abc', N'test', CAST(N'2023-02-17T15:47:17.953' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (2, 20, N'PSG', N'psg@gmail.com', N'0912345678', CAST(N'2023-02-17T15:50:58.820' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2F2%2Flogo%2F09-04-2023pngegg.png?alt=media&token=c7b450fd-f0c9-456a-a7ae-cdd6977b42c2', N'https://vi.wikipedia.org/wiki/Paris_Saint-Germain_F.C.')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (3, 9, N'Club 3', N'club1@gmail.com', N'0912345678', CAST(N'2023-02-17T16:04:48.077' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (4, 9, N'Chelsea', N'chel@gmail.com', N'1234567890', CAST(N'2023-02-27T20:38:36.253' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2F4%2Flogo%2F09-04-2023chel.png?alt=media&token=945e1d55-3e6e-4c43-b4c7-cdb6e6049fea', N'https://vi.wikipedia.org/wiki/Chelsea_F.C.')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (5, 12, N'Arsenal', N'arsenal@gmail.com', N'123456789', CAST(N'2023-03-01T23:29:35.787' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2F5%2Flogo%2F08-04-2023anh-logo-arsenal-dep_025558778.png?alt=media&token=ecfc4c64-faa5-4fe8-b415-13d8c711dc79', N'https://vi.wikipedia.org/wiki/Arsenal_F.C.')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (6, 12, N'Club Xyzt', N'Clubxzt@gmail.com', N'123456789', CAST(N'2023-03-01T23:30:24.217' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (7, 13, N'Liverpool', N'liver@gmail.com', N'123456789', CAST(N'2023-03-01T23:35:13.170' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2F7%2Flogo%2F09-04-2023Liverpool%20FC.png?alt=media&token=09aaf736-85b9-4922-ab1a-c49bf05b1135', N'https://vi.wikipedia.org/wiki/Liverpool_F.C.')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (8, 13, N'Club AYT', N'Clubayt@gmail.com', N'123456789', CAST(N'2023-03-01T23:35:23.213' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (9, 13, N'Club DEF', N'Clubdef@gmail.com', N'123456789', CAST(N'2023-03-01T23:35:31.063' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (10, 21, N'Manchester United', N'mu@gmail.com', N'1234', CAST(N'2023-03-02T21:48:06.700' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2F10%2Flogo%2F09-04-2023Manchester_united_logo.png?alt=media&token=89069de9-bfab-4fcb-8ccb-75ad9ebc6159', N'https://vi.wikipedia.org/wiki/Manchester_United_F.C.')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (11, 18, N'Manchester City', N'mc@gmail.com', N'1234', CAST(N'2023-03-02T22:14:07.963' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2F11%2Flogo%2F09-04-2023Manchester_City_logo.svg.png?alt=media&token=35dec2e2-8aea-47cb-8f6f-c76b7fdf19e6', N'https://vi.wikipedia.org/wiki/Manchester_City_F.C.')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (12, 19, N'Real Madrid', N'rm@gmail.com', N'1234', CAST(N'2023-03-02T22:14:52.923' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2F12%2Flogo%2F09-04-2023rm.jpg?alt=media&token=725e0209-27d2-4cab-aa36-4f9269279d49', N'https://vi.wikipedia.org/wiki/Real_Madrid_CF')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (13, 22, N'Barcelona', N'barca@gmail.com', N'1234', CAST(N'2023-03-02T22:48:02.017' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2F13%2Flogo%2F09-04-2023Barca.png?alt=media&token=02628c12-54d5-4c27-aa4d-8754324f856b', N'https://vi.wikipedia.org/wiki/FC_Barcelona')
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (14, 22, N'Khong biet', N'khongbiet@gmail.com', N'0912345678', CAST(N'2023-03-04T21:44:02.593' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (15, 21, N'Test Logo', N'rmtest@gmail.com', N'0912345678', CAST(N'2023-03-12T09:52:53.710' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/12-03-2023Logo_Real_Madrid.svg.png?alt=media&token=ac5ddfe2-d05a-4804-851a-37d5392bfa87', NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [CreateAt], [Logo], [FanPage]) VALUES (16, 25, N'Juventus', N'juv@gmail.com', N'0123456789', CAST(N'2023-04-09T19:13:09.957' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2FJuventus%2Flogo%2F09-04-2023juve.png?alt=media&token=6fb75181-306b-43a4-8e0a-bd4fffd621de', NULL)
SET IDENTITY_INSERT [dbo].[Club] OFF
GO
SET IDENTITY_INSERT [dbo].[ClubClone] ON 

INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (28, 6, 10, N'C1        ', 1, 0, 0, 3, 2, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (29, 6, 13, N'C2        ', 0, 0, 1, 2, 3, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (30, 6, 12, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (31, 6, 11, N'C4        ', 0, 1, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (32, 6, 7, N'C5        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (33, 6, 5, N'C6        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (34, 6, 4, N'C7        ', 0, 1, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (38, 8, NULL, N'C1        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (39, 8, 10, N'C2        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (40, 8, NULL, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (41, 8, NULL, N'C4        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (42, 8, 13, N'C5        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (43, 8, 11, N'C6        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (44, 8, NULL, N'C7        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (45, 9, 10, N'C1        ', 2, 1, 0, 7, 3, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (46, 9, 13, N'C2        ', 0, 1, 2, 3, 6, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (47, 9, 12, N'C3        ', 2, 0, 1, 5, 5, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (48, 9, 2, N'C4        ', 0, 2, 1, 3, 4, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (49, 10, 4, N'C1        ', 0, 0, 0, 1, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (50, 10, 7, N'C2        ', 0, 0, 0, 0, 1, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (51, 10, 5, N'C3        ', 0, 0, 0, 2, 1, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (52, 10, 2, N'C4        ', 0, 0, 0, 1, 2, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (53, 10, 10, N'C5        ', 0, 0, 0, 3, 1, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (54, 10, 12, N'C6        ', 0, 0, 0, 1, 3, NULL)
SET IDENTITY_INSERT [dbo].[ClubClone] OFF
GO
SET IDENTITY_INSERT [dbo].[League] ON 

INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (6, 4, N'Highland Football League', 7, CAST(N'2023-03-10T00:00:00.000' AS DateTime), CAST(N'2023-03-11T00:00:00.000' AS DateTime), 10, 7, N'FU', N'https://www.google.com/search?q=football+league&tbm=isch&ved=2ahUKEwiEx6WbqqL-AhUFMN4KHQKaAGIQ2-cCegQIABAA&oq=football+league&gs_lcp=CgNpbWcQAzIHCAAQigUQQzIGCAAQBxAeMgYIABAHEB4yBggAEAcQHjIGCAAQBxAeMgYIABAHEB4yBggAEAcQHjIGCAAQBxAeMgYIABAHEB4yBggAEAcQHjoECCMQJ1COA1iOA2CBBWgAcAB4AIABTYgBjwGSAQEymAEAoAEBqgELZ3dzLXdpei1pbWfAAQE&sclient=img&ei=sZU1ZMSqNYXg-AaCtIKQBg&bih=688&biw=1536#imgrc=fKzs8R-7sMg-LM', CAST(N'2023-03-10T11:13:16.670' AS DateTime), N'A league with test able data, league type is league, 7 participate, 10 player per team, 7 player in squad', N'LEAGUE', 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2F6%2Flogo%2F12-04-2023Highland_Football_League_(emblem).png?alt=media&token=828b9ccf-9bbd-4256-b389-aba89f94e1ac', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (8, 4, N'Football League 2023', 7, CAST(N'2023-03-14T17:00:00.000' AS DateTime), CAST(N'2023-03-16T17:00:00.000' AS DateTime), 12, 7, N'FU', N'ABC', CAST(N'2023-03-15T16:15:10.500' AS DateTime), N'League that can test with type is KO', N'KO', NULL, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2F8%2Flogo%2F12-04-2023Foot_ball_league.png?alt=media&token=4b4722e6-87fe-42cf-a52c-4a55b3d7713d', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (9, 10, N'King cup 2023', 4, CAST(N'2023-04-08T00:00:00.000' AS DateTime), CAST(N'2023-04-22T00:00:00.000' AS DateTime), 10, 7, N'Thailand', N'https://www.google.com/search?q=king+cup+2023&tbm=isch&ved=2ahUKEwj477aFuJT-AhUtt1YBHf9BB7EQ2-cCegQIABAA#imgrc=yfnMVqYSAHOizM', CAST(N'2023-04-06T11:43:07.970' AS DateTime), N'League', N'LEAGUE', NULL, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2F9%2Flogo%2F09-04-2023kingcup_logo.png?alt=media&token=95ffe377-2c4d-45fa-ab1e-d85353fe9e87', 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (10, 4, N'Super Club 2023', 6, CAST(N'2023-04-04T00:00:00.000' AS DateTime), CAST(N'2023-04-20T00:00:00.000' AS DateTime), 10, 7, N'England', N'https://www.google.com/search?q=super+cup+logo&tbm=isch&ved=2ahUKEwjrleHrhqL-AhW0gFYBHdpvD1EQ2-cCegQIABAA&oq=super+cup+logo&gs_lcp=CgNpbWcQAzIHCAAQgAQQEzIHCAAQgAQQEzIICAAQBRAeEBMyCAgAEAUQHhATMggIABAFEB4QEzIICAAQBRAeEBMyCAgAEAUQHhATMggIABAFEB4QEzIICAAQBRAeEBMyCAgAEAUQHhATOgQIIxAnOgUIABCABFDnAljOCGDiCWgAcAB4AIABbIgB7QOSAQM1LjGYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=mnA1ZOvgObSB2roP2t-9iAU#imgrc=aMSBDbltaGE5xM', CAST(N'2023-04-11T21:42:18.363' AS DateTime), N'Super cup', N'KO', NULL, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FSuper%20Club%202023%2Flogo%2F11-04-2023super_cup.jpg?alt=media&token=b47c125e-770b-4545-9580-55e127330717', 0)
SET IDENTITY_INSERT [dbo].[League] OFF
GO
SET IDENTITY_INSERT [dbo].[LeagueFee] ON 

INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (17, 6, N'F0', N'Sponsored', 1000000.0000, 0, N'Sponsored')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (18, 6, N'F1', N'Gold Medal', 1000000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (19, 6, N'F2', N'Silver Medal', 50000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (20, 6, N'F3', N'Bronze Medal', 10000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (21, 6, N'F4', N'Best Player', 5000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (22, 6, N'F5', N'Top Score', 5000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (23, 6, N'F6', N'Top assist', 5000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (24, 6, N'F7', N'Best GK', 5000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (25, 6, N'Fx', N'Best Fan', 2000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (26, 6, N'Ff', N'Field', 2000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (27, 6, N'Ff', N'Water', 3000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (31, 8, N'F0', N'Sponsored', 2000000.0000, 0, N'Sponsored')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (32, 8, N'F1', N'Gold Medal', 1000000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (33, 8, N'F2', N'Silver Medal', 500000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (34, 8, N'F3', N'Bronze Medal', 200000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (35, 8, N'F4', N'Best Player', 50000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (36, 8, N'F5', N'Top Score', 50000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (37, 8, N'F6', N'Top assist', 50000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (38, 8, N'F7', N'Best GK', 50000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (39, 8, N'Ff', N'Ref', 200000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (40, 8, N'Ff', N'Field', 200000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (41, 9, N'F0', N'Sponsored', 10000000.0000, 0, N'Sponsored')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (42, 9, N'F1', N'Gold Medal', 5000000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (43, 9, N'F2', N'Silver Medal', 2000000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (44, 9, N'F3', N'Bronze Medal', 1000000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (45, 9, N'F4', N'Best Player', 200000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (46, 9, N'F5', N'Top Score', 200000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (47, 9, N'F6', N'Top assist', 200000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (48, 9, N'F7', N'Best GK', 200000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (49, 9, N'Fx', N'Best Fan', 500000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (50, 9, N'Fx', N'Ref', 5000000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (51, 9, N'Fx', N'Water', 1000000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (52, 9, N'Fx', N'Field', 1000000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (53, 9, N'Fx', N'Sponsored', 1000000.0000, 1, N'Sponsored')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (54, 9, N'Fx', N'Gold Medal', 5000000.0000, 1, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (55, 9, N'Fx', N'Silver Medal', 2000000.0000, 1, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (56, 9, N'Fx', N'Bronze Medal', 1000000.0000, 1, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (57, 10, N'F0', N'Sponsored', 20000000.0000, 0, N'Sponsored')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (58, 10, N'F1', N'Gold Medal', 10000000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (59, 10, N'F2', N'Silver Medal', 5000000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (60, 10, N'F3', N'Bronze Medal', 2000000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (61, 10, N'F4', N'Best Player', 500000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (62, 10, N'F5', N'Top Score', 500000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (63, 10, N'F6', N'Top assist', 500000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (64, 10, N'F7', N'Best GK', 500000.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (65, 10, N'Fx', N'Water', 1000000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (66, 10, N'Fx', N'Ref', 1000000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (67, 10, N'Fx', N'Field', 2000000.0000, 0, N'Fee')
SET IDENTITY_INSERT [dbo].[LeagueFee] OFF
GO
SET IDENTITY_INSERT [dbo].[Match] ON 

INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (56, 6, 36, 35, CAST(N'2023-03-10T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (57, 6, 38, 37, CAST(N'2023-03-10T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (58, 6, 40, 39, CAST(N'2023-03-10T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (59, 6, 41, 35, CAST(N'2023-03-12T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (60, 6, 38, 36, CAST(N'2023-03-12T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (61, 6, 39, 37, CAST(N'2023-03-12T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (62, 6, 38, 35, CAST(N'2023-03-14T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (63, 6, 40, 41, CAST(N'2023-03-14T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (64, 6, 39, 36, CAST(N'2023-03-14T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (65, 6, 40, 35, CAST(N'2023-03-16T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (66, 6, 39, 38, CAST(N'2023-03-16T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (67, 6, 37, 41, CAST(N'2023-03-16T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (68, 6, 39, 35, CAST(N'2023-03-18T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (69, 6, 37, 40, CAST(N'2023-03-18T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (70, 6, 36, 41, CAST(N'2023-03-18T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (71, 6, 37, 35, CAST(N'2023-03-20T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (72, 6, 36, 40, CAST(N'2023-03-20T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (73, 6, 41, 38, CAST(N'2023-03-20T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (74, 6, 36, 37, CAST(N'2023-03-22T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (75, 6, 41, 39, CAST(N'2023-03-22T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (76, 6, 38, 40, CAST(N'2023-03-22T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (80, 8, 46, 45, CAST(N'2023-03-16T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (81, 8, 48, 47, CAST(N'2023-03-14T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (82, 8, 49, 51, CAST(N'2023-03-14T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (83, 8, 53, 52, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (84, 8, 55, 54, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (85, 8, 57, 56, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (86, 9, 59, 58, CAST(N'2023-04-18T15:00:00.000' AS DateTime), 1, N'Round 1', N'Thailand')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (87, 9, 61, 60, CAST(N'2023-04-08T00:00:00.000' AS DateTime), 1, N'Round 1', N'Thailand')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (88, 9, 61, 58, CAST(N'2023-04-10T00:00:00.000' AS DateTime), 1, N'Round 2', N'Thailand')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (89, 9, 60, 59, CAST(N'2023-04-10T00:00:00.000' AS DateTime), 1, N'Round 2', N'Thailand')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (90, 9, 60, 58, CAST(N'2023-04-12T00:00:00.000' AS DateTime), 1, N'Round 3', N'Thailand')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (91, 9, 59, 61, CAST(N'2023-04-12T00:00:00.000' AS DateTime), 1, N'Round 3', N'Thailand')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (92, 10, 63, 62, CAST(N'2023-04-20T00:00:00.000' AS DateTime), 0, N'Final', N'England')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (93, 10, 65, 64, CAST(N'2023-04-18T00:00:00.000' AS DateTime), 0, N'Semi Final', N'England')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (94, 10, 68, 67, CAST(N'2023-04-18T00:00:00.000' AS DateTime), 1, N'Semi Final', N'England')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (95, 10, 70, 69, CAST(N'2023-04-16T00:00:00.000' AS DateTime), 1, N'Quater Final', N'England')
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (96, 10, 72, 71, CAST(N'2023-04-16T00:00:00.000' AS DateTime), 1, N'Quater Final', N'England')
SET IDENTITY_INSERT [dbo].[Match] OFF
GO
SET IDENTITY_INSERT [dbo].[MatchEvent] ON 

INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (2, 34, NULL, 56, N'Goal', 3, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (3, 18, NULL, 56, N'OwnGoal', 27, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (4, 24, 19, 56, N'Goal', 56, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (5, 22, NULL, 56, N'YellowCard', 60, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (6, 18, NULL, 56, N'RedCard', 70, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (7, 37, 29, 56, N'Goal ', 1, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (12, 29, NULL, 56, N'OwnGoal', 4, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (13, 6, 7, 87, N'Goal', 5, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (14, 10, 11, 87, N'Goal', 37, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (15, 167, 171, 87, N'Goal', 47, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (16, 9, 171, 87, N'YellowCard', 56, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (17, 112, 27, 88, N'Goal', 19, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (18, 112, 34, 88, N'Goal', 26, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (19, 32, 34, 88, N'YellowCard', 35, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (20, 10, 11, 88, N'Goal', 48, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (21, 34, 27, 88, N'Goal', 77, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (22, 171, NULL, 89, N'Goal', 56, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (23, 171, NULL, 89, N'OwnGoal', 88, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (24, 112, 27, 90, N'Goal', 8, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (25, 167, 171, 90, N'Goal', 67, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (26, 129, 22, 91, N'Goal', 56, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (27, 17, 22, 91, N'OwnGoal', 7, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (28, 6, 7, 91, N'Goal', 7, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (29, 34, 112, 86, N'Goal', 55, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (30, 20, 18, 86, N'Goal', 59, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (31, 34, 27, 86, N'Goal', 89, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (32, 112, 27, 86, N'Goal', 91, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (33, 140, NULL, 94, N'Goal', 4, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (34, 118, 123, 95, N'Goal', 5, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (35, 161, 123, 95, N'OwnGoal', 17, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (36, 167, 171, 95, N'Goal', 22, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (37, 34, 27, 96, N'Goal', 7, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (38, 112, 27, 96, N'Goal', 56, 1)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (39, 10, 6, 96, N'Goal', 46, 0)
INSERT [dbo].[MatchEvent] ([MatchEventId], [MainId], [SubId], [MatchId], [EventType], [EventTime], [IsHome]) VALUES (40, 32, 112, 96, N'Goal', 78, 1)
SET IDENTITY_INSERT [dbo].[MatchEvent] OFF
GO
SET IDENTITY_INSERT [dbo].[MatchStat] ON 

INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (1, 56, 1, 2, 2, 3, 2, 2, 1, 3, 3)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (2, 56, 0, 3, 4, 7, 8, 3, 2, 9, 2)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (3, 57, 1, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (4, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (7, 87, 1, 2, 5, 3, 6, 2, 1, 1, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (8, 87, 0, 1, 9, 4, 3, 3, 3, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (9, 88, 1, 1, 4, 2, 2, 4, 2, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (10, 88, 0, 3, 5, 4, 8, 2, 3, 1, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (11, 89, 1, 1, 4, 1, 5, 4, 2, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (12, 89, 0, 1, 3, 3, 7, 3, 2, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (13, 90, 1, 1, 3, 0, 5, 0, 2, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (14, 90, 0, 1, 5, 2, 3, 1, 5, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (15, 91, 1, 1, 5, 4, 2, 0, 2, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (16, 91, 0, 2, 7, 1, 2, 1, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (17, 86, 1, 1, 6, 3, 5, 2, 3, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (18, 86, 0, 3, 10, 6, 7, 5, 5, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (19, 94, 1, 1, 3, 1, 2, 4, 1, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (20, 94, 0, 0, 2, 1, 3, 2, 2, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (21, 95, 1, 2, 3, 2, 1, 1, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (22, 95, 0, 1, 3, 2, 1, 1, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (23, 96, 1, 3, 4, 2, 2, 5, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (24, 96, 0, 1, 5, 3, 1, 2, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[MatchStat] OFF
GO
SET IDENTITY_INSERT [dbo].[ParticipateNode] ON 

INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (35, 0, 28, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (36, 0, 29, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (37, 0, 34, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (38, 0, 31, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (39, 0, 33, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (40, 0, 32, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (41, 0, 30, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (45, 3, NULL, 2, 1, 6, 7, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (46, 2, NULL, 2, 1, 4, 5, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (47, 5, NULL, 3, 2, 10, 11, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (48, 4, NULL, 3, 2, 8, 9, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (49, 6, NULL, 3, 3, 12, 13, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (50, 1, NULL, 1, 0, 2, 3, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (51, 7, 38, 3, 3, 0, 0, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (52, 9, 40, 4, 4, 0, 0, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (53, 8, 39, 4, 4, 0, 0, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (54, 11, 42, 4, 5, 0, 0, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (55, 10, 41, 4, 5, 0, 0, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (56, 13, 44, 4, 6, 0, 0, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (57, 12, 43, 4, 6, 0, 0, 8)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (58, 0, 45, 0, NULL, NULL, NULL, 9)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (59, 0, 46, 0, NULL, NULL, NULL, 9)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (60, 0, 48, 0, NULL, NULL, NULL, 9)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (61, 0, 47, 0, NULL, NULL, NULL, 9)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (62, 3, 49, 2, 1, 6, 7, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (63, 2, NULL, 2, 1, 4, 5, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (64, 5, 53, 3, 2, 10, 11, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (65, 4, 51, 3, 2, 8, 9, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (66, 1, NULL, 1, 0, 2, 3, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (67, 7, 50, 3, 3, 0, 0, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (68, 6, 49, 3, 3, 0, 0, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (69, 9, 52, 4, 4, 0, 0, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (70, 8, 51, 4, 4, 0, 0, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (71, 11, 54, 4, 5, 0, 0, 10)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (72, 10, 53, 4, 5, 0, 0, 10)
SET IDENTITY_INSERT [dbo].[ParticipateNode] OFF
GO
SET IDENTITY_INSERT [dbo].[ParticipateRequest] ON 

INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (30, 6, 13, N'Invite', N'Accepted', CAST(N'2023-03-10T11:15:13.810' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (31, 6, 12, N'Invite', N'Accepted', CAST(N'2023-03-10T11:16:21.860' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (32, 6, 11, N'Invite', N'Accepted', CAST(N'2023-03-10T11:16:49.617' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (33, 6, 10, N'Invite', N'Accepted', CAST(N'2023-03-10T11:17:01.853' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (34, 6, 7, N'Invite', N'Accepted', CAST(N'2023-03-10T11:17:21.963' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (35, 6, 5, N'Invite', N'Accepted', CAST(N'2023-03-10T11:17:35.583' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (36, 6, 4, N'Invite', N'Accepted', CAST(N'2023-03-10T11:17:53.287' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (37, 6, 2, N'Invite', N'Canceled', CAST(N'2023-03-10T11:18:42.297' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (38, 6, 3, N'Invite', N'Canceled', CAST(N'2023-03-10T11:18:47.703' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (39, 6, 15, N'Register', N'Rejected', CAST(N'2023-03-12T20:22:25.747' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (41, 8, 10, N'Invite', N'Accepted', CAST(N'2023-03-15T17:21:33.947' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (42, 8, 13, N'Invite', N'Accepted', CAST(N'2023-03-15T17:21:56.447' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (43, 8, 11, N'Invite', N'Accepted', CAST(N'2023-03-15T17:22:55.440' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (44, 8, 15, N'Register', N'Rejected', CAST(N'2023-03-23T22:04:53.947' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (45, 9, 10, N'Invite', N'Accepted', CAST(N'2023-04-06T11:45:17.337' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (46, 9, 7, N'Invite', N'Accepted', CAST(N'2023-04-06T11:45:35.427' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (47, 9, 13, N'Invite', N'Accepted', CAST(N'2023-04-06T11:45:44.673' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (48, 9, 12, N'Invite', N'Accepted', CAST(N'2023-04-06T11:46:31.460' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (49, 9, 2, N'Invite', N'Accepted', CAST(N'2023-04-06T11:46:53.277' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (50, 10, 5, N'Invite', N'Accepted', CAST(N'2023-04-11T21:44:23.810' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (51, 10, 2, N'Invite', N'Accepted', CAST(N'2023-04-11T21:44:32.613' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (52, 10, 7, N'Invite', N'Accepted', CAST(N'2023-04-11T21:44:40.823' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (53, 10, 10, N'Invite', N'Accepted', CAST(N'2023-04-11T21:47:40.823' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (54, 10, 12, N'Invite', N'Accepted', CAST(N'2023-04-11T21:47:54.653' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (55, 10, 4, N'Invite', N'Accepted', CAST(N'2023-04-11T21:48:01.027' AS DateTime))
SET IDENTITY_INSERT [dbo].[ParticipateRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[Participation] ON 

INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (10, 6, 13, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (11, 6, 12, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (12, 6, 10, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (13, 6, 11, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (14, 6, 7, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (15, 6, 5, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (17, 6, 4, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (19, 8, 10, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FTestable%20League%20(Type%3A%20KO)%2Fevidence%2FManchester%20United%2F15-03-2023Logo_Real_Madrid.svg.png?alt=media&token=99888094-e7e5-48f2-988d-88c146421ea7', CAST(N'2023-03-15T17:28:37.070' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (20, 8, 13, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FTestable%20League%20(Type%3A%20KO)%2Fevidence%2FBarcelona%2F24-03-2023channels4_profile.jpg?alt=media&token=df0571d6-3c59-4a00-bcdc-e20a910c9ba9', CAST(N'2023-03-15T17:28:54.970' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (21, 8, 11, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FTestable%20League%20(Type%3A%20KO)%2Fevidence%2FManchester%20City%2F28-03-2023channels4_profile.jpg?alt=media&token=c50c0fd5-afc0-451b-be52-b22d9386c9ca', CAST(N'2023-03-15T17:30:15.703' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (22, 9, 10, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FKing%20cup%202023%2Fevidence%2FManchester%20United%2F06-04-2023New-Text-Document.txt?alt=media&token=3e51bfcb-d96e-4fd3-b383-d5f2ddaa6364', CAST(N'2023-04-06T11:48:55.293' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (23, 9, 13, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FKing%20cup%202023%2Fevidence%2FBarcelona%2F06-04-2023Untitled%20(2).png?alt=media&token=ab9b70a3-6330-4626-9215-89b004320791', CAST(N'2023-04-06T11:51:07.083' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (25, 9, 12, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FKing%20cup%202023%2Fevidence%2FReal%20Madrid%2F06-04-2023kingcup_logo.png?alt=media&token=57c38c35-a79e-47ba-a1e6-2bed4c01e4d4', CAST(N'2023-04-06T11:53:56.570' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (26, 9, 2, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FKing%20cup%202023%2Fevidence%2FPSG%2F06-04-2023kingcup_logo.png?alt=media&token=fa197514-c6d7-4f7d-8859-2a6a08a49fe7', CAST(N'2023-04-06T11:59:57.947' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (27, 10, 5, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FSuper%20Club%202023%2Fevidence%2FArsenal%2F11-04-2023Ars.png?alt=media&token=93d76cf0-09d4-4a66-abe1-da7e742872fe', CAST(N'2023-04-11T22:11:43.090' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (28, 10, 10, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FSuper%20Club%202023%2Fevidence%2FManchester%20United%2F11-04-2023Ars.png?alt=media&token=5a7df8bc-57c6-42eb-ab44-6835764dcfae', CAST(N'2023-04-11T22:12:02.747' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (29, 10, 2, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FSuper%20Club%202023%2Fevidence%2FPSG%2F11-04-2023Ars.png?alt=media&token=1ed7f948-e7f4-4071-bb53-d1ce71ea8bf7', CAST(N'2023-04-11T22:12:14.440' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (30, 10, 12, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FSuper%20Club%202023%2Fevidence%2FReal%20Madrid%2F11-04-2023Ars.png?alt=media&token=06a994f9-9c4c-4c9f-beb2-db62e20b9dfa', CAST(N'2023-04-11T22:12:49.177' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (31, 10, 4, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FSuper%20Club%202023%2Fevidence%2FChelsea%2F11-04-2023Ars.png?alt=media&token=64c02f62-288d-46e4-ade2-d2feb4e15f72', CAST(N'2023-04-11T22:13:33.017' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (32, 10, 7, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FSuper%20Club%202023%2Fevidence%2FLiverpool%2F11-04-2023Ars.png?alt=media&token=ae706c1a-9bc4-4ac4-be1e-1d17a25a51dd', CAST(N'2023-04-11T22:13:52.153' AS DateTime))
SET IDENTITY_INSERT [dbo].[Participation] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (2, N'Player 1', N'anh', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (3, N'Player 2', N'anh2', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (4, N'Ninh Duc Anh', N'ninhkhoai07', CAST(N'2001-06-20T17:00:00.000' AS DateTime), N'1m72', N'63kg', N'Long Bien', N'ninhducanh', N'ducanh2106@gmail.com', N'anhnd', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (5, N'Messiii', N'mes', CAST(N'2017-02-06T17:00:00.000' AS DateTime), N'1m69', N'70kg', N'Spain', N'0', N'messi@gmail.com', N'00111', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmes%2Favatar%2F09-04-2023PSG_LMessi.jpg?alt=media&token=cc7b29b5-1576-4f0b-a598-42c083a628af')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (6, N'Vinicius Jr', N'vjr', CAST(N'2000-03-07T17:00:00.000' AS DateTime), N'1m72', N'65kg', N'RM', N'0', N'aaa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fvjr%2Favatar%2F09-04-2023Real_VLucas%20.jpg?alt=media&token=058a2896-4512-4595-a0c9-611bafacbf55')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (7, N'Toni Kross', N'tkross', CAST(N'1997-03-02T17:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ftkross%2Favatar%2F09-04-2023Real_LModric.jpg?alt=media&token=13a186c1-c2e3-4c01-a079-62932b5da5cd')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (8, N'T Courtois', N'ct', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fct%2Favatar%2F09-04-2023Real_TCourtois.jpg?alt=media&token=b156a4c3-bb87-4551-91ad-cdb5dbe8aa35')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (9, N'CARVAJAL', N'aat', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Faat%2Favatar%2F09-04-2023Real_ARudiger.jpg?alt=media&token=7f7ed511-e234-4ef8-9546-c65ab0f85c0f')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (10, N'Karim Benzema', N'ben', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fben%2Favatar%2F09-04-2023Real_KBenzema.jpg?alt=media&token=6dd35a56-129a-4fe6-9258-d6d7bce6a7c1')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (11, N'Hazard', N'haz', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fhaz%2Favatar%2F09-04-2023Real_EHazard.jpg?alt=media&token=26864c92-a60d-4d6f-8d56-a2b890de0fcf')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (12, N'David Alaba', N'ala', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fala%2Favatar%2F09-04-2023Real_DAlaba.jpg?alt=media&token=3fbe5255-fcc8-438d-b769-9037779ef586')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (13, N'NACHO', N'nac', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fnac%2Favatar%2F09-04-2023Real_VLucas%20.jpg?alt=media&token=736cf02d-0f6b-47f0-83ab-eb4df561bace')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (14, N'VALVERDE', N'val', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fval%2Favatar%2F09-04-2023Real_FSValverde.jpg?alt=media&token=c324f823-fcb9-4f2b-a02d-d482bde76ee6')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (15, N'M Asensio', N'ase', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fase%2Favatar%2F09-04-2023Real_MAsensio.jpg?alt=media&token=6dda80e0-9976-4283-9845-59671c82e45e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (16, N'RODRYGO', N'rod', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frod%2Favatar%2F09-04-2023Real_GRodrygo.jpg?alt=media&token=7ca065b1-5e1a-437c-98fb-116d8ceb7ec1')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (17, N'ter Stegen', N'steg', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0123', N'aa@gmail.com', N'0123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fsteg%2Favatar%2F09-04-2023Barca_TStegen.png?alt=media&token=57edfd4e-52b7-4bdf-a41c-89fa47c6ee84')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (18, N'Marcos Alonso', N'mara', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'091', N'aa@gmail.com', N'09', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmara%2Favatar%2F09-04-2023Barca_ABalde.png?alt=media&token=622be5df-ec4b-45c3-9c27-13ff1c1671d7')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (19, N'Jordi Alba', N'jor', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'09', N'aa@gmail.com', N'09', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fjor%2Favatar%2F09-04-2023Barca_RAraujo.png?alt=media&token=5d6453cd-dfc8-4665-8f18-1b473c43d136')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (20, N'Busquets', N'bus', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fbus%2Favatar%2F09-04-2023Barca_BSergio.png?alt=media&token=dcd45e76-07e3-4696-a92e-8451868e51ca')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (21, N'Pedri', N'pedri', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'09', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fpedri%2Favatar%2F09-04-2023Barca_IPena.png?alt=media&token=a8132cfc-a782-4c87-8803-3d7ecc96e92c')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (22, N'Frenkie De Jong', N'dejong', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fdejong%2Favatar%2F09-04-2023dejong.jpg?alt=media&token=40f0d8ce-eb27-49cc-8382-5e76405a3804')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (23, N'Gavi', N'gavi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fgavi%2Favatar%2F09-04-2023Barca_PMPGavira.png?alt=media&token=2c404015-3ebe-4eeb-bd4c-74678a233306')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (24, N'Raphinha', N'raphi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fraphi%2Favatar%2F09-04-2023Barca_ODembele.png?alt=media&token=0fab77d6-52b4-45c7-868b-773120d2ab6e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (25, N'Ferran Torres', N'ferran', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fferran%2Favatar%2F09-04-2023Barca_PTorre.png?alt=media&token=0f8def09-d3bc-4684-af32-431b6e091dd8')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (26, N'Sergi Roberto', N'sergi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'091234', N'aa@gmail.com', N'12341', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fsergi%2Favatar%2F09-04-2023Barca_SRoberto.png?alt=media&token=7676b5ed-7a24-4313-8c3b-f29d0b422c80')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (27, N'Bruno Fernandes', N'bru', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fbru%2Favatar%2F09-04-2023MU_BFernandes.png?alt=media&token=65af49fa-172c-40c3-b88a-537abf1e9166')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (28, N'Harry Maguire', N'marguire', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmarguire%2Favatar%2F09-04-2023MU_HMaguire.png?alt=media&token=80c6eece-4e50-4f2a-8207-6627028d0445')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (29, N'Aaron Wan Bissaka', N'wansabi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fwansabi%2Favatar%2F09-04-2023MU_AWan-Bissaka.png?alt=media&token=2ceea72e-2b4e-4f66-afa4-a94acc126674')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (30, N'Fred', N'fred', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ffred%2Favatar%2F09-04-2023MU_Fred.png?alt=media&token=7a02e9fc-7d10-4b21-867a-7b8316966df9')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (31, N'Eric Bailly', N'bally', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fbally%2Favatar%2F09-04-2023MU_EBailly.png?alt=media&token=a5ab95b2-9f0d-459a-a763-6a89eae9af11')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (32, N'Marcus Rashford', N'rash', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frash%2Favatar%2F09-04-2023MU_MRashford.png?alt=media&token=360976b9-9bab-4dbd-a2cb-abf59cdf07ed')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (33, N'Luke Shaw', N'shaw', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fshaw%2Favatar%2F09-04-2023MU_LShaw.png?alt=media&token=49333f44-356e-4dde-8a05-b51403398141')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (34, N'Robin van Persie', N'rvp', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frvp%2Favatar%2F09-04-2023rvp.jpg?alt=media&token=509d3b6a-ef1e-416d-a45e-e37a87f03d5e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (35, N'David de Gea', N'degea', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fdegea%2Favatar%2F09-04-2023MU_DdeGea.png?alt=media&token=cd3418f4-48ea-493f-8582-7030d4ffa585')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (36, N'Nani', N'nani', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fnani%2Favatar%2F09-04-2023monaco-eye-20m-nani.jpg?alt=media&token=d7810a3f-b6dc-45f0-9bb1-e1d302e43adc')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (37, N'Cristiano Ronaldo', N'cr7', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fcr7%2Favatar%2F09-04-2023MU_CRonaldo.png?alt=media&token=4d95baf0-fe08-4a6b-a0f4-bb067f38c810')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (38, N'Ederson', N'ede', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fede%2Favatar%2F09-04-2023MC_Ederson.png?alt=media&token=eb847c48-a443-4e5a-968b-c9d5f1389f48')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (39, N'Dias', N'dias', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fdias%2Favatar%2F09-04-2023MC_RDias.png?alt=media&token=d029a606-53a2-445f-a309-a7dc806b1da1')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (40, N'Kyle Walker', N'kyle', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fkyle%2Favatar%2F09-04-2023MC_KWalker.png?alt=media&token=66934389-8b80-455b-bee5-19761fc2c2c6')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (41, N'John Stones', N'stones', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fstones%2Favatar%2F09-04-2023MC_JStone.png?alt=media&token=ae32fa08-2ddc-4e7e-8e49-c2580daeb4e2')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (42, N'Jack Grealish', N'jack', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fjack%2Favatar%2F09-04-2023MC_JGrealish.png?alt=media&token=f25b81cb-cbb0-47d4-8b3b-39d60f7cea28')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (43, N'Rodri', N'rodri', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frodri%2Favatar%2F09-04-2023MC_JCancelo.png?alt=media&token=963aa9c8-c912-4f65-bdca-9b1b4bd70f35')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (44, N'Kevin De Bruyne', N'kevin', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fkevin%2Favatar%2F09-04-2023MC_KDeBruyne.png?alt=media&token=dae22064-aef0-4513-af15-42ac128df5f2')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (45, N'Bernardo Silva', N'silva', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fsilva%2Favatar%2F09-04-2023MC_BSilva.png?alt=media&token=0191f0ea-2866-4177-ae65-5fd299ec925d')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (46, N'Phil Foden', N'phil', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fphil%2Favatar%2F09-04-2023MC_FTorres.png?alt=media&token=5d748c98-c55e-4ab1-a543-700118b153e0')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (47, N'Erling Haaland', N'haaland', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fhaaland%2Favatar%2F09-04-2023MC_EHaaland.png?alt=media&token=a9f0e83e-706e-4802-895c-6108353ec3b9')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (48, N'Riyad Mahrez', N'mahrez', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmahrez%2Favatar%2F09-04-2023MC_RSterling.png?alt=media&token=4c790c13-2062-40f1-b693-ca695c3cdf74')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (49, N'Alisson', N'alisson', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Falisson%2Favatar%2F09-04-2023Liv_Alisson.png?alt=media&token=fe3210d1-ef09-4105-b2c4-1dbb87175c8f')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (50, N'Virgil van Dijk', N'vandijk', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fvandijk%2Favatar%2F09-04-2023Liv_VvDijk.png?alt=media&token=edf9d158-e847-42a9-b9fc-584120652df7')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (51, N'Ibrahima Konate', N'konate', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fkonate%2Favatar%2F09-04-2023Liv_IKonat%C3%A9.png?alt=media&token=3b8bc989-e593-4e93-95e7-96740a0cf3d9')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (52, N'Thiago', N'thiago', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fthiago%2Favatar%2F09-04-2023Liv_JGomez.png?alt=media&token=24c902f4-8265-4674-84c8-9463c4477a73')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (53, N'Diogo Jota', N'jota', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fjota%2Favatar%2F09-04-2023Liv_LDiaz.png?alt=media&token=bbe7d8ba-5722-4ad3-a739-f06a7a3a0496')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (54, N'Darwin Nunez', N'nunez', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fnunez%2Favatar%2F09-04-2023Liv_DNunez.png?alt=media&token=ab7f2fd5-33b3-4c86-8258-ad1301fd2937')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (55, N'Fabio Carvalho', N'fabio', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'0', N'aa@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ffabio%2Favatar%2F09-04-2023Liv_FCarvalho.png?alt=media&token=0e27e8aa-932a-48a9-bcd1-658c14d1f89e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (56, N'Player 1', N'anh', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (57, N'Player 2', N'anh2', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (58, N'Ninh Duc Anh', N'ninhkhoai07', CAST(N'2001-06-20T17:00:00.000' AS DateTime), N'1m72', N'63kg', N'Long Bien', N'ninhducanh', N'ducanh2106@gmail.com', N'anhnd', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (59, N'Messiii', N'mes', CAST(N'2017-02-06T17:00:00.000' AS DateTime), N'1m69', N'70kg', N'Spain', N'aaaa', N'messi@gmail.com', N'messsiiii', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (60, N'Vinicius Jr', N'vjr', CAST(N'2000-03-07T17:00:00.000' AS DateTime), N'1m72', N'65kg', N'RM', N'aa', N'aaa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (61, N'Toni Kross', N'tkross', CAST(N'1997-03-02T17:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (62, N'COURTOIS', N'ct', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (63, N'CARVAJAL', N'aat', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (64, N'BENZEMA', N'ben', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (65, N'HAZARD', N'haz', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (66, N'ALABA', N'ala', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (67, N'NACHO', N'nac', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (68, N'VALVERDE', N'val', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (69, N'ASENSIO', N'ase', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (70, N'RODRYGO', N'rod', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (71, N'ter Stegen', N'steg', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (72, N'Marcos Alonso', N'mara', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (73, N'Jordi Alba', N'jor', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (74, N'Busquets', N'bus', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (75, N'Pedri', N'pedri', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (76, N'Frenkie De Jong', N'dejong', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (77, N'Gavi', N'gavi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (78, N'Raphinha', N'raphi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (79, N'Ferran Torres', N'ferran', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (80, N'Sergi Roberto', N'sergi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (81, N'Bruno Fernandes', N'bru', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (82, N'Harry Maguire', N'marguire', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (83, N'Aaron Wan-Bissaka', N'wansabi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (84, N'Fred', N'fred', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (85, N'Eric Bailly', N'bally', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (86, N'Marcus Rashford', N'rash', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (87, N'Luke Shaw', N'shaw', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (88, N'Robin van Persie', N'rvp', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (89, N'David de Gea', N'degea', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (90, N'Nani', N'nani', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (91, N'Cristiano Ronaldo', N'cr7', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (92, N'Ederson', N'ede', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (93, N'Dias', N'dias', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (94, N'Kyle Walker', N'kyle', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (95, N'John Stones', N'stones', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (96, N'Jack Grealish', N'jack', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (97, N'Rodri', N'rodri', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (98, N'Kevin De Bruyne', N'kevin', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (99, N'Bernardo Silva', N'silva', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (100, N'Phil Foden', N'phil', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
GO
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (101, N'Erling Haaland', N'haaland', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (102, N'Riyad Mahrez', N'mahrez', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (103, N'Alisson', N'alisson', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (104, N'Virgil van Dijk', N'vandijk', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (105, N'Ibrahima Konate', N'konate', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (106, N'Thiago', N'thiago', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (107, N'Diogo Jota', N'jota', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (108, N'Darwin Nunez', N'nunez', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (109, N'Fabio Carvalho', N'fabio', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (110, N'aaaa', N'abc', CAST(N'2023-03-12T17:00:00.000' AS DateTime), N'1m2', N'54kg', N'a', N'a', N'a@gmail.com', N'a', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (111, N'Playera', N'nda12', CAST(N'2001-01-31T17:00:00.000' AS DateTime), N'1m72', N'a', N'abc', N'a', N'nda', N'a', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (112, N'Ninh Vu Duc Anh', N'envydiace', CAST(N'2001-06-21T00:00:00.000' AS DateTime), N'1m72', N'64kg', N'gia quat', N'0915936216', N'anhndhe150329@fpt.edu.vn', N'0012010043218', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fenvydiace%2Favatar%2F09-04-2023ava.jpg?alt=media&token=06ffec92-dd5d-4166-ab30-929dd4d40aec')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (113, N'Ramsdale', N'ard', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2FArsenal%2Fplayer%2FRamsdale%2FplayerNickName%2Fard%2FplayerAva%2F08-04-2023?alt=media&token=93c8ad0f-583f-46aa-be5a-f5960404bbdf')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (114, N'Ben White', N'bwh', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fbwh%2Favatar%2F09-04-2023Ars_BWhite.jpg?alt=media&token=009b545a-9afd-4754-b99c-823015b4412b')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (115, N'ESRowe', N'esro', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fesro%2Favatar%2F09-04-2023Ars_ESRowe.jpg?alt=media&token=695c148b-4032-4ce2-8306-934fb84faf26')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (116, N'FVieira', N'fvie', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ffvie%2Favatar%2F09-04-2023Ars_FVieira.jpg?alt=media&token=2c5cce2b-2165-404b-892a-c8affe177e87')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (117, N'Gabriel', N'gabr', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fgabr%2Favatar%2F09-04-2023Ars_Gabriel.jpg?alt=media&token=c5d07f04-73c1-46b8-93a6-5106de8cc96f')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (118, N'GJesus', N'gjes', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fgjes%2Favatar%2F09-04-2023Ars_GJesus.jpg?alt=media&token=db9c373d-64ba-4959-a486-39cd33482b62')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (119, N'GMartinelli', N'gamr', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fgamr%2Favatar%2F09-04-2023Ars_GMartinelli.jpg?alt=media&token=e157038f-b02f-4d82-8ad7-73035c0f6c6f')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (120, N'GXhaka', N'gxha', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fgxha%2Favatar%2F09-04-2023Ars_GXhaka.jpg?alt=media&token=a6c053ed-197b-47b6-ad75-32d4f264dd9b')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (121, N'Jorginho', N'jorgi', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fjorgi%2Favatar%2F09-04-2023Ars_Jorginho.jpg?alt=media&token=cb0c7ff6-088c-4990-83bf-517cc1bfde67')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (122, N'LTrossard', N'ltro', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fltro%2Favatar%2F09-04-2023Ars_LTrossard.jpg?alt=media&token=38485db5-1967-464f-9e07-e18cff3006ac')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (123, N'MOdegaard', N'mode', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmode%2Favatar%2F09-04-2023Ars_MOdegaard.jpg?alt=media&token=a146f4ec-9e04-4ed2-8cee-9c5011352b80')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (124, N'MTurner', N'mtur', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmtur%2Favatar%2F09-04-2023Ars_MTurner.jpg?alt=media&token=40ea61e6-6c42-4562-9137-4c188e8a401d')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (125, N'Zincheko', N'zinc', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fzinc%2Favatar%2F09-04-2023Ars_OZinchenko.png?alt=media&token=5e0ed338-6371-4113-b021-838e7246dcab')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (126, N'RNelson', N'rnel', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frnel%2Favatar%2F09-04-2023Ars_RNelson.jpg?alt=media&token=ddfee294-5c5b-47a8-aa3b-870abae46d8e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (127, N'TPartey', N'tpar', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ftpar%2Favatar%2F09-04-2023Ars_TPartey.jpg?alt=media&token=1200e79b-c744-4750-8268-5eff634a58d0')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (128, N'WSaliba', N'wsal', CAST(N'1990-04-03T00:00:00.000' AS DateTime), N'1m8', N'68kg', N'London', N'012345678', N'abc@gmail.com', N'012345678', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fwsal%2Favatar%2F09-04-2023Ars_WSaliba.jpg?alt=media&token=95992503-0b32-4b26-87cf-1a18bb6018c7')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (129, N'Robert Lewandowski', N'rlewan', CAST(N'1993-02-09T00:00:00.000' AS DateTime), N'1m95', N'80kg', N'barca', N'091234567', N'lewan@gmail.com', N'0123754342', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2FBarcelona%2Fplayer%2FRobert%20Lewandowski%2FplayerNickName%2Frlewan%2FplayerAva%2F09-04-2023?alt=media&token=1dc9fe8a-6a36-42bb-88c8-6d45ef7e0b50')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (130, N'Ben Chilweel', N'bchil', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2FChelsea%2Fplayer%2FBen%20Chilweel%2FplayerNickName%2Fbchil%2FplayerAva%2F09-04-2023?alt=media&token=f9d806c7-6b65-468b-91a7-dc8c3c64f0d7')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (131, N'Callum Hudson Odoi', N'chodoi', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fchodoi%2Favatar%2F09-04-2023Chel_CHudson-Odoi.png?alt=media&token=35502e0a-77f9-4d21-a141-7fcd1b7b6fe3')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (132, N'Edouard Mendy', N'edmend', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fedmend%2Favatar%2F09-04-2023Chel_EMendy.png?alt=media&token=bb31857a-5155-4671-bd8d-c0b0379e6894')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (133, N'Kepa', N'ekepa', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fekepa%2Favatar%2F09-04-2023Chel_Kepa.png?alt=media&token=b93ea222-8b28-4a05-b4f2-ff23a19a082d')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (134, N'LBaker', N'lbak', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Flbak%2Favatar%2F09-04-2023Chel_LBaker.png?alt=media&token=434cc36f-9dce-4a5d-8552-f8af3ea1f67e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (135, N'M Alonso', N'maalons', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmaalons%2Favatar%2F09-04-2023Chel_MAlonso.png?alt=media&token=7f6b39f1-baa0-42c1-a1da-17b3b625fd91')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (136, N'Mason Mount', N'msmou', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmsmou%2Favatar%2F09-04-2023Chel_MMount.png?alt=media&token=65be5a97-b96e-4d16-bdd0-997ad6874e46')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (137, N'RBarkley', N'rbark', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frbark%2Favatar%2F09-04-2023Chel_RBarkley.png?alt=media&token=2e5bbee5-de51-41a8-9dbc-8e49537455c2')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (138, N'R James', N'rjam', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frjam%2Favatar%2F09-04-2023Chel_RJames.png?alt=media&token=5d04c421-49e9-462f-8a8d-71a568e377ee')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (139, N'R Loftus Cheek', N'rlo', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frlo%2Favatar%2F09-04-2023Chel_RLoftus-Cheek.png?alt=media&token=724b2c2b-576c-4c8b-b2f5-a3026f8cff58')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (140, N'Romelu Lukaku', N'roluka', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Froluka%2Favatar%2F09-04-2023Chel_RLukaku.png?alt=media&token=bada703c-57f6-4f60-a207-ae06f0006619')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (141, N'TChalobah', N'tchal', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ftchal%2Favatar%2F09-04-2023Chel_TChalobah.png?alt=media&token=13ffa078-4c90-49d3-aed0-c329529efc6e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (142, N'Thiago Silva', N'thsil', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fthsil%2Favatar%2F09-04-2023Chel_TSilva.png?alt=media&token=6adacb0a-2884-4fb7-9edb-cb5a482e161b')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (143, N'Timo Werner', N'tiwer', CAST(N'1994-07-05T00:00:00.000' AS DateTime), N'1m78', N'80kg', N'Chel, London', N'091234567', N'abc@gmail.com', N'01234', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ftiwer%2Favatar%2F09-04-2023Chel_TWerner.png?alt=media&token=04015ca4-5057-4083-827b-d79155a36278')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (144, N'AMelo', N'amel', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2FJuventus%2Fplayer%2FAMelo%2FplayerNickName%2Famel%2FplayerAva%2F09-04-2023?alt=media&token=9612db9a-92b8-46d7-b7a6-d3bd2493e3d5')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (145, N'AMorata', N'amora', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Famora%2Favatar%2F09-04-2023Juve_AMorata.png?alt=media&token=347a3f75-d201-469b-ac3f-62200d522f6d')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (146, N'ASandro', N'asand', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fasand%2Favatar%2F09-04-2023Juve_ASandro.png?alt=media&token=ef153590-c28c-4344-a7f9-1150bf78c793')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (147, N'CPinsoglio', N'cpinsog', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fcpinsog%2Favatar%2F09-04-2023Juve_CPinsoglio.png?alt=media&token=51a63289-4a85-4033-9992-161287df6f84')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (148, N'Danilo', N'danil', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fdanil%2Favatar%2F09-04-2023Juve_Danilo.png?alt=media&token=971b788a-7311-479b-b624-33bfff172770')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (149, N'DKulusevski', N'dkulusev', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fdkulusev%2Favatar%2F09-04-2023Juve_DKulusevski.png?alt=media&token=632e670f-6138-4583-b727-07e60af78b29')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (150, N'DRugani', N'druga', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fdruga%2Favatar%2F09-04-2023Juve_DRugani.png?alt=media&token=02cd78e7-2126-418e-b49a-3b261ef25398')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (151, N'FChiesa', N'fchie', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ffchie%2Favatar%2F09-04-2023Juve_FChiesa.png?alt=media&token=8c9e267a-76d3-4d2d-a4ce-d79c4b2e86ca')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (152, N'M de Ligt', N'mdeli', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmdeli%2Favatar%2F09-04-2023Juve_MdeLigt.png?alt=media&token=eaaec95d-83d8-437d-9078-13ea0ca64289')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (153, N'M De Sciglio', N'scigli', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fscigli%2Favatar%2F09-04-2023Juve_MDeSciglio.png?alt=media&token=934d0dcc-cdfb-4d7e-a27f-69935da9764e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (154, N'MKean', N'mkean', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmkean%2Favatar%2F09-04-2023Juve_MKean.png?alt=media&token=5fa57b24-583c-4751-914a-d1be5d313480')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (155, N'MLocatelli', N'mlocat', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmlocat%2Favatar%2F09-04-2023Juve_MLocatelli.png?alt=media&token=4c2ecd0f-ce19-4659-8ad9-0311b37bd20b')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (156, N'MPerin', N'mperin', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmperin%2Favatar%2F09-04-2023Juve_MPerin.png?alt=media&token=639b0fa2-88f8-4478-a697-1900d1a6f6e9')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (157, N'RBentancur', N'rbent', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frbent%2Favatar%2F09-04-2023Juve_RBentancur.png?alt=media&token=d0da6552-4a36-4f83-8aa8-8625835bd4a7')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (158, N'W Szczesny', N'wszcze', CAST(N'1997-03-10T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Italy', N'0123456789', N'abc@gmail.com', N'0010232123', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fwszcze%2Favatar%2F09-04-2023Juve_WSzczesny.png?alt=media&token=657bf566-165d-4e60-b6d1-d02bc6595951')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (159, N'ARobertson', N'arober', CAST(N'1993-06-10T00:00:00.000' AS DateTime), N'1m8', N'80kg', N'Liver', N'012345678', N'abc@gmail.com', N'1234567', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2FLiverpool%2Fplayer%2FARobertson%2FplayerNickName%2Farober%2FplayerAva%2F09-04-2023?alt=media&token=51584a07-1f27-4202-afa5-836eacfc1839')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (160, N'Trend Alexander Arnold', N'taarnol', CAST(N'1993-07-12T00:00:00.000' AS DateTime), N'1m89', N'80kg', N'Live', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2FLiverpool%2Fplayer%2FTrend%20Alexander%20Arnold%2FplayerNickName%2Ftaarnol%2FplayerAva%2F09-04-2023?alt=media&token=236360ca-deee-4a70-bcc9-da843bb8ff09')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (161, N'A Hakimi', N'ahaki', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/club%2FPSG%2Fplayer%2FA%20Hakimi%2FplayerNickName%2Fahaki%2FplayerAva%2F09-04-2023?alt=media&token=43c1bd9c-18dd-4cc2-af0b-36c0961af16e')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (162, N'CSoler', N'csoler', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fcsoler%2Favatar%2F09-04-2023PSG_CSoler.jpg?alt=media&token=2dd71310-9fce-4a96-8f3d-7950fbfca3fa')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (163, N'FRuiz', N'fruiz', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ffruiz%2Favatar%2F09-04-2023PSG_FRuiz.jpg?alt=media&token=c3f9d3ae-2dcd-44ca-821a-dcbba02b11a5')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (164, N'Donnarumma', N'donnaru', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fdonnaru%2Favatar%2F09-04-2023PSG_GDonnarumma.png?alt=media&token=0ee7d0b7-8237-4981-9cc0-25187c5f32ec')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (165, N'HEkitike', N'hekit', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fhekit%2Favatar%2F09-04-2023PSG_HEkitike.jpg?alt=media&token=79eb1775-8887-4abf-8749-15c899333717')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (166, N'JBernat', N'jbernat', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fjbernat%2Favatar%2F09-04-2023PSG_JBernat.png?alt=media&token=4d5d560a-d90a-4b3d-afc5-035f400e76d0')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (167, N'Kylian Mbappe', N'm3p', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fm3p%2Favatar%2F09-04-2023PSG_KMbappe.jpg?alt=media&token=f1e87f14-d0f4-4cf9-bfff-32c84664020f')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (168, N'Lionel Messi', N'lm10', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Flm10%2Favatar%2F09-04-2023PSG_LMessi.jpg?alt=media&token=8d59b521-6592-4378-9251-40f852355059')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (169, N'Marquinhos', N'marquinhos', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmarquinhos%2Favatar%2F09-04-2023PSG_Marquinhos.png?alt=media&token=9c82742d-dc88-402e-bb5f-bcd8f51705a1')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (170, N'MVerratti', N'mverratti', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmverratti%2Favatar%2F09-04-2023PSG_MVerratti.jpg?alt=media&token=1ac30ed4-71be-41d6-9142-6517bb4ed3c6')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (171, N'Neymar', N'neymar', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fneymar%2Favatar%2F09-04-2023PSG_Neymar.jpg?alt=media&token=eba1fb23-ca68-4896-a47e-8e1c928827bd')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (172, N'MNendes', N'mnendes', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fmnendes%2Favatar%2F09-04-2023PSG_NMendes.jpg?alt=media&token=a22567e9-949c-4009-8035-226afcbb703b')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (173, N'RSanches', N'rsanches', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Frsanches%2Favatar%2F09-04-2023PSG_RSanches.jpg?alt=media&token=157dad44-f0c6-424a-9a26-0e3b83bc1a56')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (174, N'Sergio Ramos', N'sramos', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Fsramos%2Favatar%2F09-04-2023PSG_SRamos.png?alt=media&token=b59f0767-8bd1-4f28-ae41-4a4a44ba7194')
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (175, N'TPembele', N'tpembele', CAST(N'1998-06-10T00:00:00.000' AS DateTime), N'1m83', N'82kg', N'paris', N'0', N'abc@gmail.com', N'0', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/player%2Ftpembele%2Favatar%2F09-04-2023PSG_TPembele.png?alt=media&token=519cc02b-3a28-4c4d-b529-ac6cdc117433')
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
SET IDENTITY_INSERT [dbo].[PlayerClub] ON 

INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (2, 2, 3, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (3, 3, 3, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (4, 4, 14, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (6, 6, 12, 10)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (7, 7, 12, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (8, 8, 12, 1)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (9, 9, 12, 2)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (10, 10, 12, 9)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (11, 11, 12, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (12, 12, 12, 4)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (13, 13, 12, 6)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (14, 14, 12, 15)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (15, 15, 12, 11)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (16, 16, 12, 21)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (17, 17, 13, 1)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (18, 18, 13, 13)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (19, 19, 13, 18)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (20, 20, 13, 5)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (21, 21, 13, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (22, 22, 13, 21)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (23, 23, 13, 6)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (24, 24, 13, 22)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (25, 25, 13, 11)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (26, 26, 13, 20)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (27, 27, 10, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (28, 28, 10, 5)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (29, 29, 10, 29)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (30, 30, 10, 17)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (31, 31, 10, 3)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (32, 32, 10, 10)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (33, 33, 10, 23)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (34, 34, 10, 20)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (35, 35, 10, 1)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (36, 36, 10, 11)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (37, 37, 10, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (38, 38, 11, 31)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (39, 39, 11, 3)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (40, 40, 11, 2)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (41, 41, 11, 5)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (42, 42, 11, 10)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (43, 43, 11, 16)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (44, 44, 11, 17)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (45, 45, 11, 21)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (46, 46, 11, 47)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (47, 47, 11, 9)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (48, 48, 11, 26)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (49, 49, 7, 1)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (50, 50, 7, 4)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (51, 51, 7, 5)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (52, 52, 7, 6)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (53, 53, 7, 20)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (54, 54, 7, 27)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (55, 55, 7, 28)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (57, 112, 10, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (58, 113, 5, 1)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (59, 114, 5, 5)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (60, 115, 5, 4)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (61, 116, 5, 6)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (62, 117, 5, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (63, 118, 5, 9)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (64, 119, 5, 10)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (65, 120, 5, 14)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (66, 121, 5, 2)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (67, 122, 5, 3)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (68, 123, 5, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (69, 124, 5, 25)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (70, 125, 5, 11)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (71, 126, 5, 15)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (72, 127, 5, 16)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (73, 128, 5, 17)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (74, 129, 13, 9)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (75, 130, 4, 21)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (76, 131, 4, 17)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (77, 132, 4, 1)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (78, 133, 4, 25)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (79, 134, 4, 4)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (80, 135, 4, 2)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (81, 136, 4, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (82, 137, 4, 5)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (83, 138, 4, 3)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (84, 139, 4, 21)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (85, 140, 4, 10)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (86, 141, 4, 12)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (87, 142, 4, 3)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (88, 143, 4, 9)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (89, 144, 16, 2)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (90, 145, 16, 10)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (91, 146, 16, 11)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (92, 147, 16, 12)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (93, 148, 16, 13)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (94, 149, 16, 14)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (95, 150, 16, 15)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (96, 151, 16, 20)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (97, 152, 16, 5)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (98, 153, 16, 6)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (99, 154, 16, 23)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (100, 155, 16, 24)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (101, 156, 16, 25)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (102, 157, 16, 26)
GO
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (103, 158, 16, 1)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (104, 159, 7, 3)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (105, 160, 7, 2)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (106, 161, 2, 2)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (107, 162, 2, 3)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (108, 163, 2, 4)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (109, 164, 2, 1)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (110, 165, 2, 15)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (111, 166, 2, 16)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (112, 167, 2, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (113, 168, 2, 30)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (114, 169, 2, 5)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (115, 170, 2, 28)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (116, 171, 2, 10)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (117, 172, 2, 35)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (118, 173, 2, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (119, 174, 2, 4)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (120, 175, 2, 18)
SET IDENTITY_INSERT [dbo].[PlayerClub] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshToken] ON 

INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (25, 7, N'gqozd1zJJMWsAB8KYFw0OK/gJPprPUIVdSQCEtocp3c=', N'3C4yiSJn09FOhmTbfj9iTydK2WGUgW7RiFAs+JxD/+4=', CAST(N'2023-02-03T21:24:00' AS SmallDateTime), CAST(N'2023-02-03T21:25:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (27, 8, N'o51/t8SukSEO0ziGTaZrlpRisSHbkvXRR7nnyUUHR7U=', N'lJJO9etrl5uaNj3YzwpK26NL1zphTlaax5UccFCdrSA=', CAST(N'2023-02-05T23:17:00' AS SmallDateTime), CAST(N'2023-02-05T23:18:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (97, 11, N'v9QEfKDz6kmFRoDrR2QTyhQppE5uS9VITfG3AMIssMA=', N'hfyuiM7DmP9DAZX851Jp4GiAeTVjILlC0EOlh2Gb8iI=', CAST(N'2023-03-01T10:11:00' AS SmallDateTime), CAST(N'2023-03-01T10:12:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (113, 17, N'RIEnyyq11vkEoZ4DGR0ukGJauPjpGEoy4Z6Zo5tmiO4=', N'L2LZO2SLTH8TGGc2/kUGtGln4ezZ3HVDfwvtu2xwSd0=', CAST(N'2023-03-02T21:47:00' AS SmallDateTime), CAST(N'2023-03-02T21:48:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (114, 4, N'pgNQvemsV96w+wsmXNIFAJGOcmcuJaHJmM28aeLlaM0=', N'+tQJBTYbfy/JwBF2suJTLEX88MfAeLsbaP+Ko3vsqz8=', CAST(N'2023-04-12T00:14:00' AS SmallDateTime), CAST(N'2023-04-12T00:15:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[RefreshToken] OFF
GO
SET IDENTITY_INSERT [dbo].[Squad] ON 

INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (19, 56, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (20, 56, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (21, 57, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (22, 57, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (23, 58, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (24, 58, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (25, 59, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (26, 59, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (27, 60, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (28, 60, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (29, 61, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (30, 61, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (31, 62, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (32, 62, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (33, 63, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (34, 63, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (35, 64, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (36, 64, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (37, 65, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (38, 65, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (39, 66, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (40, 66, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (41, 67, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (42, 67, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (43, 68, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (44, 68, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (45, 69, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (46, 69, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (47, 70, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (48, 70, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (49, 71, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (50, 71, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (51, 72, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (52, 72, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (53, 73, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (54, 73, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (55, 74, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (56, 74, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (57, 75, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (58, 75, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (59, 76, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (60, 76, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (67, 80, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (68, 80, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (69, 81, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (70, 81, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (71, 82, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (72, 82, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (73, 83, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (74, 83, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (75, 84, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (76, 84, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (77, 85, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (78, 85, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (79, 86, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (80, 86, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (81, 87, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (82, 87, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (83, 88, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (84, 88, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (85, 89, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (86, 89, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (87, 90, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (88, 90, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (89, 91, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (90, 91, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (91, 92, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (92, 92, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (93, 93, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (94, 93, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (95, 94, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (96, 94, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (97, 95, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (98, 95, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (99, 96, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (100, 96, 0, 7)
SET IDENTITY_INSERT [dbo].[Squad] OFF
GO
SET IDENTITY_INSERT [dbo].[SquadPosition] ON 

INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (253, 19, N'P1', 17)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (254, 19, N'P2', 18)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (255, 19, N'P3', 20)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (256, 19, N'P4', 22)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (257, 19, N'P5', 21)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (258, 19, N'P6', 19)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (259, 19, N'P7', 24)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (260, 19, N'P0', 25)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (261, 19, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (262, 19, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (263, 20, N'P1', 35)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (264, 20, N'P2', 31)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (265, 20, N'P3', 28)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (266, 20, N'P4', 29)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (267, 20, N'P5', 30)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (268, 20, N'P6', 27)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (269, 20, N'P7', 34)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (270, 20, N'P0', 37)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (271, 20, N'P0', 36)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (272, 20, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (273, 21, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (274, 21, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (275, 21, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (276, 21, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (277, 21, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (278, 21, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (279, 21, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (280, 21, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (281, 21, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (282, 21, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (283, 22, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (284, 22, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (285, 22, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (286, 22, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (287, 22, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (288, 22, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (289, 22, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (290, 22, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (291, 22, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (292, 22, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (293, 23, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (294, 23, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (295, 23, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (296, 23, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (297, 23, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (298, 23, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (299, 23, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (300, 23, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (301, 23, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (302, 23, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (303, 24, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (304, 24, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (305, 24, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (306, 24, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (307, 24, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (308, 24, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (309, 24, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (310, 24, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (311, 24, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (312, 24, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (313, 25, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (314, 25, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (315, 25, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (316, 25, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (317, 25, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (318, 25, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (319, 25, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (320, 25, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (321, 25, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (322, 25, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (323, 26, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (324, 26, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (325, 26, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (326, 26, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (327, 26, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (328, 26, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (329, 26, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (330, 26, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (331, 26, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (332, 26, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (333, 27, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (334, 27, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (335, 27, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (336, 27, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (337, 27, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (338, 27, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (339, 27, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (340, 27, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (341, 27, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (342, 27, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (343, 28, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (344, 28, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (345, 28, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (346, 28, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (347, 28, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (348, 28, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (349, 28, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (350, 28, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (351, 28, N'P0', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (352, 28, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (353, 29, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (354, 29, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (355, 29, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (356, 29, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (357, 29, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (358, 29, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (359, 29, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (360, 29, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (361, 29, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (362, 29, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (363, 30, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (364, 30, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (365, 30, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (366, 30, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (367, 30, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (368, 30, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (369, 30, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (370, 30, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (371, 30, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (372, 30, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (373, 31, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (374, 31, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (375, 31, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (376, 31, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (377, 31, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (378, 31, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (379, 31, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (380, 31, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (381, 31, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (382, 31, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (383, 32, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (384, 32, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (385, 32, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (386, 32, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (387, 32, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (388, 32, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (389, 32, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (390, 32, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (391, 32, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (392, 32, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (393, 33, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (394, 33, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (395, 33, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (396, 33, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (397, 33, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (398, 33, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (399, 33, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (400, 33, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (401, 33, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (402, 33, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (403, 34, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (404, 34, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (405, 34, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (406, 34, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (407, 34, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (408, 34, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (409, 34, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (410, 34, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (411, 34, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (412, 34, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (413, 35, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (414, 35, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (415, 35, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (416, 35, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (417, 35, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (418, 35, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (419, 35, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (420, 35, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (421, 35, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (422, 35, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (423, 36, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (424, 36, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (425, 36, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (426, 36, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (427, 36, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (428, 36, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (429, 36, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (430, 36, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (431, 36, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (432, 36, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (433, 37, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (434, 37, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (435, 37, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (436, 37, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (437, 37, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (438, 37, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (439, 37, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (440, 37, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (441, 37, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (442, 37, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (443, 38, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (444, 38, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (445, 38, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (446, 38, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (447, 38, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (448, 38, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (449, 38, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (450, 38, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (451, 38, N'P0', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (452, 38, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (453, 39, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (454, 39, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (455, 39, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (456, 39, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (457, 39, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (458, 39, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (459, 39, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (460, 39, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (461, 39, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (462, 39, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (463, 40, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (464, 40, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (465, 40, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (466, 40, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (467, 40, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (468, 40, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (469, 40, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (470, 40, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (471, 40, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (472, 40, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (473, 41, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (474, 41, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (475, 41, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (476, 41, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (477, 41, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (478, 41, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (479, 41, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (480, 41, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (481, 41, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (482, 41, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (483, 42, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (484, 42, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (485, 42, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (486, 42, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (487, 42, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (488, 42, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (489, 42, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (490, 42, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (491, 42, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (492, 42, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (493, 43, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (494, 43, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (495, 43, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (496, 43, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (497, 43, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (498, 43, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (499, 43, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (500, 43, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (501, 43, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (502, 43, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (503, 44, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (504, 44, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (505, 44, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (506, 44, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (507, 44, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (508, 44, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (509, 44, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (510, 44, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (511, 44, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (512, 44, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (513, 45, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (514, 45, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (515, 45, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (516, 45, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (517, 45, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (518, 45, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (519, 45, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (520, 45, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (521, 45, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (522, 45, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (523, 46, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (524, 46, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (525, 46, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (526, 46, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (527, 46, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (528, 46, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (529, 46, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (530, 46, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (531, 46, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (532, 46, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (533, 47, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (534, 47, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (535, 47, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (536, 47, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (537, 47, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (538, 47, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (539, 47, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (540, 47, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (541, 47, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (542, 47, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (543, 48, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (544, 48, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (545, 48, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (546, 48, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (547, 48, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (548, 48, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (549, 48, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (550, 48, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (551, 48, N'P0', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (552, 48, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (553, 49, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (554, 49, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (555, 49, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (556, 49, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (557, 49, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (558, 49, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (559, 49, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (560, 49, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (561, 49, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (562, 49, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (563, 50, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (564, 50, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (565, 50, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (566, 50, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (567, 50, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (568, 50, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (569, 50, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (570, 50, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (571, 50, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (572, 50, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (573, 51, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (574, 51, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (575, 51, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (576, 51, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (577, 51, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (578, 51, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (579, 51, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (580, 51, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (581, 51, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (582, 51, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (583, 52, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (584, 52, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (585, 52, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (586, 52, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (587, 52, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (588, 52, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (589, 52, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (590, 52, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (591, 52, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (592, 52, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (593, 53, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (594, 53, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (595, 53, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (596, 53, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (597, 53, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (598, 53, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (599, 53, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (600, 53, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (601, 53, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (602, 53, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (603, 54, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (604, 54, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (605, 54, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (606, 54, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (607, 54, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (608, 54, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (609, 54, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (610, 54, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (611, 54, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (612, 54, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (613, 55, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (614, 55, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (615, 55, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (616, 55, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (617, 55, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (618, 55, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (619, 55, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (620, 55, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (621, 55, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (622, 55, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (623, 56, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (624, 56, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (625, 56, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (626, 56, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (627, 56, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (628, 56, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (629, 56, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (630, 56, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (631, 56, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (632, 56, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (633, 57, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (634, 57, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (635, 57, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (636, 57, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (637, 57, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (638, 57, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (639, 57, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (640, 57, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (641, 57, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (642, 57, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (643, 58, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (644, 58, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (645, 58, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (646, 58, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (647, 58, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (648, 58, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (649, 58, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (650, 58, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (651, 58, N'P0', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (652, 58, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (653, 59, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (654, 59, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (655, 59, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (656, 59, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (657, 59, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (658, 59, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (659, 59, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (660, 59, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (661, 59, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (662, 59, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (663, 60, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (664, 60, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (665, 60, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (666, 60, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (667, 60, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (668, 60, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (669, 60, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (670, 60, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (671, 60, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (672, 60, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (715, 67, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (716, 67, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (717, 67, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (718, 67, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (719, 67, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (720, 67, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (721, 67, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (722, 67, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (723, 67, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (724, 67, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (725, 67, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (726, 67, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (727, 68, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (728, 68, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (729, 68, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (730, 68, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (731, 68, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (732, 68, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (733, 68, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (734, 68, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (735, 68, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (736, 68, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (737, 68, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (738, 68, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (739, 69, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (740, 69, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (741, 69, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (742, 69, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (743, 69, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (744, 69, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (745, 69, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (746, 69, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (747, 69, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (748, 69, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (749, 69, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (750, 69, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (751, 70, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (752, 70, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (753, 70, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (754, 70, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (755, 70, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (756, 70, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (757, 70, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (758, 70, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (759, 70, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (760, 70, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (761, 70, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (762, 70, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (763, 71, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (764, 71, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (765, 71, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (766, 71, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (767, 71, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (768, 71, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (769, 71, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (770, 71, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (771, 71, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (772, 71, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (773, 71, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (774, 71, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (775, 72, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (776, 72, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (777, 72, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (778, 72, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (779, 72, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (780, 72, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (781, 72, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (782, 72, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (783, 72, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (784, 72, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (785, 72, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (786, 72, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (787, 73, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (788, 73, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (789, 73, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (790, 73, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (791, 73, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (792, 73, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (793, 73, N'P7', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (794, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (795, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (796, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (797, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (798, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (799, 74, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (800, 74, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (801, 74, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (802, 74, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (803, 74, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (804, 74, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (805, 74, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (806, 74, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (807, 74, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (808, 74, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (809, 74, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (810, 74, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (811, 75, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (812, 75, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (813, 75, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (814, 75, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (815, 75, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (816, 75, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (817, 75, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (818, 75, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (819, 75, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (820, 75, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (821, 75, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (822, 75, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (823, 76, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (824, 76, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (825, 76, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (826, 76, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (827, 76, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (828, 76, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (829, 76, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (830, 76, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (831, 76, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (832, 76, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (833, 76, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (834, 76, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (835, 77, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (836, 77, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (837, 77, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (838, 77, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (839, 77, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (840, 77, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (841, 77, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (842, 77, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (843, 77, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (844, 77, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (845, 77, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (846, 77, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (847, 78, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (848, 78, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (849, 78, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (850, 78, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (851, 78, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (852, 78, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (853, 78, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (854, 78, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (855, 78, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (856, 78, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (857, 78, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (858, 78, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (859, 79, N'P1', 17)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (860, 79, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (861, 79, N'P3', 18)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (862, 79, N'P4', 19)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (863, 79, N'P5', 20)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (864, 79, N'P6', 22)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (865, 79, N'P7', 129)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (866, 79, N'P0', 26)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (867, 79, N'P0', 25)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (868, 79, N'P0', 24)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (869, 80, N'P1', 35)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (870, 80, N'P2', 28)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (871, 80, N'P3', 33)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (872, 80, N'P4', 32)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (873, 80, N'P5', 27)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (874, 80, N'P6', 34)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (875, 80, N'P7', 112)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (876, 80, N'P0', 37)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (877, 80, N'P0', 36)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (878, 80, N'P0', 30)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (879, 81, N'P1', 8)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (880, 81, N'P2', 14)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (881, 81, N'P3', 12)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (882, 81, N'P4', 13)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (883, 81, N'P5', 6)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (884, 81, N'P6', 15)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (885, 81, N'P7', 10)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (886, 81, N'P0', 16)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (887, 81, N'P0', 11)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (888, 81, N'P0', 7)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (889, 82, N'P1', 164)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (890, 82, N'P2', 169)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (891, 82, N'P3', 161)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (892, 82, N'P4', 174)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (893, 82, N'P5', 171)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (894, 82, N'P6', 167)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (895, 82, N'P7', 168)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (896, 82, N'P0', 173)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (897, 82, N'P0', 170)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (898, 82, N'P0', 172)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (899, 83, N'P1', 8)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (900, 83, N'P2', 9)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (901, 83, N'P3', 12)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (902, 83, N'P4', 11)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (903, 83, N'P5', 7)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (904, 83, N'P6', 10)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (905, 83, N'P7', 6)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (906, 83, N'P0', 14)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (907, 83, N'P0', 13)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (908, 83, N'P0', 16)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (909, 84, N'P1', 35)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (910, 84, N'P2', 28)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (911, 84, N'P3', 29)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (912, 84, N'P4', 33)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (913, 84, N'P5', 32)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (914, 84, N'P6', 36)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (915, 84, N'P7', 34)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (916, 84, N'P0', 27)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (917, 84, N'P0', 37)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (918, 84, N'P0', 112)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (919, 85, N'P1', 164)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (920, 85, N'P2', 169)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (921, 85, N'P3', 161)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (922, 85, N'P4', 170)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (923, 85, N'P5', 171)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (924, 85, N'P6', 168)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (925, 85, N'P7', 167)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (926, 85, N'P0', 166)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (927, 85, N'P0', 174)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (928, 85, N'P0', 175)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (929, 86, N'P1', 17)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (930, 86, N'P2', 19)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (931, 86, N'P3', 20)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (932, 86, N'P4', 18)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (933, 86, N'P5', 22)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (934, 86, N'P6', 129)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (935, 86, N'P7', 24)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (936, 86, N'P0', 26)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (937, 86, N'P0', 25)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (938, 86, N'P0', 21)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (939, 87, N'P1', 164)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (940, 87, N'P2', 169)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (941, 87, N'P3', 161)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (942, 87, N'P4', 173)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (943, 87, N'P5', 171)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (944, 87, N'P6', 167)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (945, 87, N'P7', 168)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (946, 87, N'P0', 172)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (947, 87, N'P0', 174)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (948, 87, N'P0', 170)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (949, 88, N'P1', 35)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (950, 88, N'P2', 28)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (951, 88, N'P3', 29)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (952, 88, N'P4', 33)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (953, 88, N'P5', 32)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (954, 88, N'P6', 36)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (955, 88, N'P7', 112)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (956, 88, N'P0', 37)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (957, 88, N'P0', 34)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (958, 88, N'P0', 31)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (959, 89, N'P1', 17)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (960, 89, N'P2', 18)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (961, 89, N'P3', 19)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (962, 89, N'P4', 20)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (963, 89, N'P5', 22)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (964, 89, N'P6', 23)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (965, 89, N'P7', 129)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (966, 89, N'P0', 24)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (967, 89, N'P0', 25)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (968, 89, N'P0', 26)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (969, 90, N'P1', 8)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (970, 90, N'P2', 9)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (971, 90, N'P3', 7)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (972, 90, N'P4', 12)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (973, 90, N'P5', 10)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (974, 90, N'P6', 11)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (975, 90, N'P7', 6)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (976, 90, N'P0', 15)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (977, 90, N'P0', 14)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (978, 90, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (979, 91, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (980, 91, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (981, 91, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (982, 91, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (983, 91, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (984, 91, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (985, 91, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (986, 91, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (987, 91, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (988, 91, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (989, 92, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (990, 92, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (991, 92, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (992, 92, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (993, 92, N'P5', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (994, 92, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (995, 92, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (996, 92, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (997, 92, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (998, 92, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (999, 93, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1000, 93, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1001, 93, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1002, 93, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1003, 93, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1004, 93, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1005, 93, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1006, 93, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1007, 93, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1008, 93, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1009, 94, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1010, 94, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1011, 94, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1012, 94, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1013, 94, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1014, 94, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1015, 94, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1016, 94, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1017, 94, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1018, 94, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1019, 95, N'P1', 132)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1020, 95, N'P2', 130)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1021, 95, N'P3', 131)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1022, 95, N'P4', 134)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1023, 95, N'P5', 142)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1024, 95, N'P6', 138)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1025, 95, N'P7', 140)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1026, 95, N'P0', 141)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1027, 95, N'P0', 139)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1028, 95, N'P0', 143)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1029, 96, N'P1', 49)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1030, 96, N'P2', 50)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1031, 96, N'P3', 52)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1032, 96, N'P4', 53)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1033, 96, N'P5', 55)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1034, 96, N'P6', 160)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1035, 96, N'P7', 54)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1036, 96, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1037, 96, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1038, 96, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1039, 97, N'P1', 119)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1040, 97, N'P2', 113)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1041, 97, N'P3', 114)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1042, 97, N'P4', 116)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1043, 97, N'P5', 118)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1044, 97, N'P6', 121)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1045, 97, N'P7', 123)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1046, 97, N'P0', 117)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1047, 97, N'P0', 122)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1048, 97, N'P0', 120)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1049, 98, N'P1', 164)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1050, 98, N'P2', 161)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1051, 98, N'P3', 166)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1052, 98, N'P4', 170)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1053, 98, N'P5', 168)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1054, 98, N'P6', 167)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1055, 98, N'P7', 171)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1056, 98, N'P0', 169)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1057, 98, N'P0', 174)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1058, 98, N'P0', 173)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1059, 99, N'P1', 35)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1060, 99, N'P2', 28)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1061, 99, N'P3', 33)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1062, 99, N'P4', 27)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1063, 99, N'P5', 37)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1064, 99, N'P6', 32)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1065, 99, N'P7', 34)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1066, 99, N'P0', 112)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1067, 99, N'P0', 36)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1068, 99, N'P0', 31)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1069, 100, N'P1', 8)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1070, 100, N'P2', 13)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1071, 100, N'P3', 7)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1072, 100, N'P4', 9)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1073, 100, N'P5', 10)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1074, 100, N'P6', 6)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1075, 100, N'P7', 11)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1076, 100, N'P0', 15)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1077, 100, N'P0', 12)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (1078, 100, N'P0', 16)
SET IDENTITY_INSERT [dbo].[SquadPosition] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (4, N'ninhkhoai2106@gmail.com', N'ja5VxAA5bb/4RRr9JfJRve+yXIBMdan0iGuU9+HGYGk=', N'58MEo0ZtKXtt6prq28aAZ3Q1f5/Eq/JlV/ghTm0B9Z8=', N'Ninh Duc Anh', N'0915936216', N'Long Bien, Ha Noi', 1, CAST(N'2023-01-21T18:32:00.000' AS DateTime), N'LEAGUE_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FNinh%20Duc%20Anh%2Favatar%2F09-04-2023z3029525881913_ef139858eeaca613648e2099ac6f484e.jpg?alt=media&token=9a726ee7-9282-4e1a-88d1-500ebd813218', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (7, N'ducanh2106@gmail.com', N'sw1XzB7iLM/KQyRliQCgnIWuS8IVpiJ0MKna6ws4G2k=', N'UXClFXlEawuqFWgajEHSJDOcNtkTVxZQn744UW9yctM=', N'Ninh', N'0', N'Duc Anh', 1, CAST(N'2023-01-21T19:03:00.000' AS DateTime), N'CLUB_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (8, N'leagueManager@gmail.com', N'VrgBRXxtcHzQODRt1OOTAHkvmx185wkTmUXsAhucISI=', N'fZCgMhVSWNuYTqH3JGg8EqyfWYgEJfrkxj5oh6Uvp54=', N'League Mana', N'09123456', N'abcdef', 1, CAST(N'2023-02-05T23:12:00.000' AS DateTime), N'LEAGUE_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (9, N'chel@gmail.com', N'rqgExFZSIG+Tv2I4g7zX30mbHC0B6bwP/UoOvQ7wDkQ=', N'EMWf6XzHQyVGaEcwxmpaXyefHZazDI0uqnzCINjIDR4=', N'Thomas Tuchel', N'0123456789', N'ABC', 1, CAST(N'2023-02-15T23:46:00.000' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FClub%20Manager%2Favatar%2F09-04-2023skysports-thomas-tuchel-chelsea.jpg?alt=media&token=5c875a8c-290f-4c39-a4ad-b7987ca90ef9', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (10, N'league@gmail.com', N'fEqbgF3vtXEktHWnZTEQ49bejOmNqu6VvFAaxq87jn8=', N'2uuRrJQ5KBrpsgG9G+TpWYpELgrHU7axkKmsC2Uk+m4=', N'League Manager', N'1234567890', N'abcd', 1, CAST(N'2023-02-17T16:06:31.520' AS DateTime), N'LEAGUE_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (11, N'test@gmail.com', N'1DICDuOJW+c7Hdrt1xJNHRbq9rZr7NngbsyIfxRIsUQ=', N'5uiSlypZX6Yo0vdVrM2Kf1XnghPh49DcQ3++Q4PuvSA=', N'Test', N'12345678', N'abcd', 1, CAST(N'2023-02-17T16:58:14.880' AS DateTime), N'CLUB_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (12, N'ars@gmail.com', N'RlBKE4H7EJvkLlvQNMg1qw2tgRGHo+ty96RTJm5k1os=', N'VOFGRG8wK7pO5eiyxHU15iHEsdfM3kcHMifRZK5GsZk=', N'Mikel Arteta', N'0912345678', N'London', 1, CAST(N'2023-03-01T23:26:17.380' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FManager%20X%2Favatar%2F08-04-2023Mikel_Arteta_2021.png?alt=media&token=d03f8ca4-ec2b-4c13-84d8-7442e24241dc', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (13, N'liver@gmail.com', N'gLm1fqQnSH3T+5NzQp68GE9mEhY1SjE+Rds0hLlYiXI=', N'leDAyiURd2LVh81GLOLF1OYkomN65PAb7DxaD+4SvLc=', N'Jurgen Klopp', N'0912345678', N'Liver', 1, CAST(N'2023-03-01T23:34:36.577' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FManager%20Y%2Favatar%2F09-04-20230_Jurgen-Klopp-31.jpg?alt=media&token=b4c5c990-a7b6-4ebe-bb04-88c65e0dca00', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (14, N'leaguex@gmail.com', N'yOu5JU6sVuyXft9zD7BuAUr/34vw/fgWab7MSlnSDho=', N'Y/IZhV5bs+RGH2KX0S6fErufTggZJTcpMOz/o8ZKVmA=', N'Phan Anh Tung', N'1234567890', N'D203', 1, CAST(N'2023-03-02T21:39:41.493' AS DateTime), N'LEAGUE_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (15, N'leaguey@gmail.com', N'bVoH27/SgouP8hburj0W3q/koJnY9pUP5l19/fL+Mwc=', N'SzCy6DZI91F6FeoXHe+gOBeP2RG+N+Jps5KhXihv64k=', N'Nguyen Tan Phon', N'1234567890', N'Vinhome Smartcity', 1, CAST(N'2023-03-02T21:40:22.200' AS DateTime), N'LEAGUE_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (16, N'leaguez@gmail.com', N'fzzdLy83qDwL1YwDUrL8bsSxkCzXdEYIrusQZf6OqKo=', N'8UkbHI+Dq7YDRKFqAS6A7NoM6mhu9p+VXL8/qseCRfQ=', N'Nguyen Minh Son', N'1234567890', N'Fu Dom D', 1, CAST(N'2023-03-02T21:40:46.187' AS DateTime), N'LEAGUE_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (17, N'clubz@gmail.com', N'GOeXr7D+O017c0fmLrbc79eyIOg2xE85fZSB8aLangE=', N'F/JwReTlSTFHuMwfnC8pKIoGREb/doz+giIi7sIbbqo=', N'Ta Vu Minh Chau', N'1234567890', N'KTX FPT', 1, CAST(N'2023-03-02T21:41:50.800' AS DateTime), N'CLUB_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (18, N'mancity@gmail.com', N'5G1lF7YUVpyvCVCrhIrtw87I44/kahvTBSg9h4kYq9o=', N'Kg8SJTCIXVIML8koC0kL+FTQNdLo15WiMczogMr9RqA=', N'Pep Guardiola', N'1234567890', N'Manchester', 1, CAST(N'2023-03-02T22:13:03.133' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FClub%20Manager%20A%2Favatar%2F09-04-2023pep-guardiola-profile.jpg?alt=media&token=0f77876f-b9aa-43a7-b884-5f1c63ec2023', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (19, N'real@gmail.com', N'KjAe3kOjikhISCFbDWJUDs8gRl9CNPXX710NQw+2vn8=', N'RwaCUV89xHEW3bliKh4Lg90ihLukAlRVkz6UZyDAhBw=', N'Carlo Ancelotti', N'1234567890', N'Madrid', 1, CAST(N'2023-03-02T22:13:13.923' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FClub%20Manager%20B%2Favatar%2F09-04-2023Carlo_Ancelotti_2016.jpg?alt=media&token=209dbf19-040d-497e-9247-3e9e6367699f', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (20, N'psg@gmail.com', N'FH0aL3Lt4TsVdlM+BDge2j/JjgYkK5vjSQGDFaN9eX0=', N'C2skCAqwaR3A20ZU/HN+tBRCQ6HO5mEMM8k0Yj4iKvs=', N'Christophe Galtier', N'1234567890', N'Paris', 1, CAST(N'2023-03-02T22:13:23.473' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FClub%20Manager%20B%2Favatar%2F09-04-2023d65c881228c371a2eac3192f3bc3a753_XL.jpg?alt=media&token=703016c2-01f0-49ba-bd34-b41137668847', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (21, N'anhndhe150329@fpt.edu.vn', N'SLZ2O5Tgs2GDedSoS/R0zhPAKPy0JqFEnDDh+eb2kMA=', N'Ob0yjUSswNee8L0OKhoaY6BKcsA6wUW+AZKn9eJEYdQ=', N'Erik ten Hag', N'1234567890', N'Manchester', 1, CAST(N'2023-03-02T22:26:28.507' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FDuc%20Anh%20Club%20Manager%20aaaa%2Favatar%2F09-04-20230-GettyImages-1239357869-jpeg-5275-1650537497.jpg?alt=media&token=ed2e3eac-85d5-4464-82b9-f36b8d95b0b6', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (22, N'vunhatmai.mfc@gmail.com', N'JzcEfEYS/nLAJU8DUamNQ19wB3w0CT6ZN+HD5bRhP+U=', N'Pdv5E+ZuPl1iXG8F1Kc9HqPP0vdqoUX5pq6toYLSIxc=', N'Xavi', N'1234567890', N'Barcelona, Spain', 1, CAST(N'2023-03-02T22:38:41.750' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FNhat%20Mai%20Vu%2Favatar%2F09-04-2023Xavi.jpg?alt=media&token=b85aa9d6-0c16-4f6e-9dbc-0df8c0e7f095', NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (23, N'ninhducanh216@gmail.com', N'O5Ad9Eyj4ajGrvQW88IDqjDy/eNLgzv3WKjUqGF6hLk=', N'8RDEAPqVC+FETjL4wKbcMRyyGX/r9K7tT5DhUw96Q2k=', N'Ninh Duc Anh', N'0915936216', N'Thuong Thanh, Long Bien, Ha Noi', 1, CAST(N'2023-03-02T23:33:20.610' AS DateTime), N'CLUB_MANAGER', NULL, NULL, NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (24, N'firewhizsiri@gmail.com', N'3dd1CyGpbbs8WVkUu9NN0UVZA7GPrtZoeQ4NzVJ024c=', N'3AHN2tQdcek/abJvzoA9w5sZK0pZKXfUM+eHV/LK/WE=', N'NGUYEN TAN PHON', N'0123456789', N'HaNoi', 1, CAST(N'2023-03-31T19:00:43.303' AS DateTime), N'CLUB_MANAGER', NULL, N'9mVlAA8ncMvcCLQzSGKB7mUbumgpt6y64QWchJd9ny0=', CAST(N'2023-03-31T23:31:46.573' AS DateTime))
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar], [ResetToken], [TokenExpire]) VALUES (25, N'juve@gmail.com', N'nuOEF4jQkLbbQRuvmU8oTA0FNwGfo153a9ivvm76eBw=', N'MIV437o3c56Nl4mbcsbz3Kxa77NbjvOS3HPu/ZDQUqY=', N'Massimiliano Allegri', N'0912345678', N'Italy', 1, CAST(N'2023-04-09T19:07:17.383' AS DateTime), N'CLUB_MANAGER', N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/profile%2FMassimiliano%20Allegri%2Favatar%2F09-04-2023licensed-image.jpg?alt=media&token=d474c389-6631-491d-a2f9-91d213670667', NULL, NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Club]  WITH CHECK ADD  CONSTRAINT [FK__Club__UserId__412EB0B6] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Club] CHECK CONSTRAINT [FK__Club__UserId__412EB0B6]
GO
ALTER TABLE [dbo].[ClubClone]  WITH CHECK ADD  CONSTRAINT [FK_ClubClone_Club] FOREIGN KEY([ClubId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[ClubClone] CHECK CONSTRAINT [FK_ClubClone_Club]
GO
ALTER TABLE [dbo].[ClubClone]  WITH CHECK ADD  CONSTRAINT [FK_ClubClone_League] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
ON DELETE CASCADE
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
ON DELETE CASCADE
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
ON DELETE CASCADE
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
ON DELETE CASCADE
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
ON DELETE CASCADE
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
ON DELETE CASCADE
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
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlayerClub] CHECK CONSTRAINT [FK__PlayerClu__ClubI__440B1D61]
GO
ALTER TABLE [dbo].[PlayerClub]  WITH CHECK ADD  CONSTRAINT [FK__PlayerClu__Playe__4316F928] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[Player] ([PlayerId])
GO
ALTER TABLE [dbo].[PlayerClub] CHECK CONSTRAINT [FK__PlayerClu__Playe__4316F928]
GO
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD  CONSTRAINT [FK__RefreshTo__UserI__5441852A] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken] CHECK CONSTRAINT [FK__RefreshTo__UserI__5441852A]
GO
ALTER TABLE [dbo].[Squad]  WITH CHECK ADD  CONSTRAINT [FK_Squad_Match] FOREIGN KEY([MatchId])
REFERENCES [dbo].[Match] ([MatchId])
ON DELETE CASCADE
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
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SquadPosition] CHECK CONSTRAINT [FK_SquadPosition_Squad]
GO
ALTER TABLE [dbo].[ParticipateRequest]  WITH CHECK ADD  CONSTRAINT [CK__Request__Request__5441852A] CHECK  (([RequestType]='Register' OR [RequestType]='Invite'))
GO
ALTER TABLE [dbo].[ParticipateRequest] CHECK CONSTRAINT [CK__Request__Request__5441852A]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK__User__Role__59063A47] CHECK  (([Role]='CLUB_MANAGER' OR [Role]='LEAGUE_MANAGER'))
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK__User__Role__59063A47]
GO
USE [master]
GO
ALTER DATABASE [FLMS_DB] SET  READ_WRITE 
GO
