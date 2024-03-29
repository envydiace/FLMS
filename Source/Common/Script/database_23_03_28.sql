USE [master]
GO
/****** Object:  Database [FLMS_DB]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Schema [HangFire]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [dbo].[Club]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[ClubClone]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[League]    Script Date: 3/28/2023 10:51:33 AM ******/
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
	[IsFinished] [bit] NOT NULL,
 CONSTRAINT [PK__League__10ABBCF4E505BDC3] PRIMARY KEY CLUSTERED 
(
	[LeagueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeagueFee]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[Match]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[MatchEvent]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[MatchStat]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[ParticipateNode]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[ParticipateRequest]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[Participation]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[Player]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[PlayerClub]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[Squad]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[SquadPosition]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 3/28/2023 10:51:33 AM ******/
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
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CX_HangFire_Counter]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE CLUSTERED INDEX [CX_HangFire_Counter] ON [HangFire].[Counter]
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](200) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 3/28/2023 10:51:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Club] ON 

INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (1, 9, N'club test', N'abc', N'test', N'test', CAST(N'2023-02-17T15:47:17.953' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (2, 9, N'PSG', N'club1@gmail.com', N'0912345678', N'abcdef', CAST(N'2023-02-17T15:50:58.820' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (3, 9, N'Club 3', N'club1@gmail.com', N'0912345678', N'abcdef', CAST(N'2023-02-17T16:04:48.077' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (4, 9, N'Chelsea', N'ClubA@gmail.com', N'1234567890', N'abc', CAST(N'2023-02-27T20:38:36.253' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (5, 12, N'Arsenal', N'Clubx@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:29:35.787' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (6, 12, N'Club Xyzt', N'Clubxzt@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:30:24.217' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (7, 13, N'Liverpool', N'Clubabc@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:35:13.170' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (8, 13, N'Club AYT', N'Clubayt@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:35:23.213' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (9, 13, N'Club DEF', N'Clubdef@gmail.com', N'123456789', N'abc', CAST(N'2023-03-01T23:35:31.063' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (10, 21, N'Manchester United', N'mu@gmail.com', N'1234', N'MU', CAST(N'2023-03-02T21:48:06.700' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (11, 18, N'Manchester City', N'mc@gmail.com', N'1234', N'MC', CAST(N'2023-03-02T22:14:07.963' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (12, 19, N'Real Madrid', N'rm@gmail.com', N'1234', N'RM', CAST(N'2023-03-02T22:14:52.923' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (13, 22, N'Barcelona', N'barca@gmail.com', N'1234', N'Barca', CAST(N'2023-03-02T22:48:02.017' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (14, 22, N'Khong biet', N'khongbiet@gmail.com', N'0912345678', N'NMV', CAST(N'2023-03-04T21:44:02.593' AS DateTime), NULL, NULL)
INSERT [dbo].[Club] ([ClubId], [UserId], [ClubName], [Email], [PhoneNumber], [SocialCont], [CreateAt], [Logo], [Kit]) VALUES (15, 21, N'Test Logo', N'rmtest@gmail.com', N'0912345678', N'aaaaaa', CAST(N'2023-03-12T09:52:53.710' AS DateTime), N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/12-03-2023Logo_Real_Madrid.svg.png?alt=media&token=ac5ddfe2-d05a-4804-851a-37d5392bfa87', N'a')
SET IDENTITY_INSERT [dbo].[Club] OFF
GO
SET IDENTITY_INSERT [dbo].[ClubClone] ON 

INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (1, 1, NULL, N'C1        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (2, 1, NULL, N'C2        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (3, 1, NULL, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (4, 1, NULL, N'C4        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (5, 1, NULL, N'C5        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (6, 2, 3, N'C1        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (7, 2, NULL, N'C2        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (8, 2, NULL, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (9, 2, NULL, N'C4        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (10, 2, NULL, N'C5        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (11, 2, NULL, N'C6        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (12, 2, NULL, N'C7        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (13, 3, 13, N'C1        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (14, 3, NULL, N'C2        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (15, 3, NULL, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (16, 3, NULL, N'C4        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (17, 3, NULL, N'C5        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (18, 3, NULL, N'C6        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (19, 3, NULL, N'C7        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (20, 4, 3, N'C1        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (21, 4, NULL, N'C2        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (22, 4, NULL, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (23, 4, NULL, N'C4        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (24, 5, NULL, N'C1        ', 0, 1, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (25, 5, NULL, N'C2        ', 0, 1, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (26, 5, NULL, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (27, 5, NULL, N'C4        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (28, 6, 10, N'C1        ', 1, 0, 0, 3, 2, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (29, 6, 13, N'C2        ', 0, 0, 1, 2, 3, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (30, 6, 12, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (31, 6, 11, N'C4        ', 0, 1, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (32, 6, 7, N'C5        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (33, 6, 5, N'C6        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (34, 6, 4, N'C7        ', 0, 1, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (35, 7, NULL, N'C1        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (36, 7, NULL, N'C2        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (37, 7, NULL, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (38, 8, NULL, N'C1        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (39, 8, 10, N'C2        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (40, 8, NULL, N'C3        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (41, 8, NULL, N'C4        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (42, 8, 13, N'C5        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (43, 8, 11, N'C6        ', 0, 0, 0, 0, 0, NULL)
INSERT [dbo].[ClubClone] ([ClubCloneId], [LeagueId], [ClubId], [ClubCloneKey], [Won], [Draw], [Loss], [GoalsFor], [GoalsAgainst], [Rank]) VALUES (44, 8, NULL, N'C7        ', 0, 0, 0, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[ClubClone] OFF
GO
SET IDENTITY_INSERT [dbo].[League] ON 

INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (1, 10, N'League Knock-out 5 team', 5, CAST(N'2023-02-28T17:00:00.000' AS DateTime), CAST(N'2023-03-15T17:00:00.000' AS DateTime), 20, 11, N'Hoa Lac', N'fuhoalac', CAST(N'2023-02-26T15:25:50.800' AS DateTime), NULL, N'KO', 1, NULL, 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (2, 10, N'League Round table 7 team', 7, CAST(N'2023-02-28T17:00:00.000' AS DateTime), CAST(N'2023-03-15T17:00:00.000' AS DateTime), 20, 11, N'FPT Hoa Lac', N'fuhoalac', CAST(N'2023-02-26T15:29:10.363' AS DateTime), NULL, N'LEAGUE', 1, NULL, 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (3, 4, N'Super League 2023', 7, CAST(N'2023-03-02T15:28:03.087' AS DateTime), CAST(N'2023-03-04T15:28:03.087' AS DateTime), 20, 11, N'FPT', N'superleague', CAST(N'2023-03-02T22:32:26.163' AS DateTime), N'The super league in 2023', N'LEAGUE', 1, NULL, 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (4, 4, N'Test League 5 squad max 15', 4, CAST(N'2023-03-07T04:09:28.677' AS DateTime), CAST(N'2023-03-08T04:09:28.677' AS DateTime), 15, 5, N'FU', N'abc', CAST(N'2023-03-07T11:11:03.053' AS DateTime), N'string', N'LEAGUE', 1, NULL, 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (5, 4, N'Test K.O 7 squad max 12', 4, CAST(N'2023-03-07T04:09:28.677' AS DateTime), CAST(N'2023-03-08T04:09:28.677' AS DateTime), 12, 7, N'FU', N'abc', CAST(N'2023-03-07T11:13:42.507' AS DateTime), N'string', N'KO', 1, NULL, 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (6, 4, N'Testable League (type: league)', 7, CAST(N'2023-03-10T00:00:00.000' AS DateTime), CAST(N'2023-03-11T00:00:00.000' AS DateTime), 10, 7, N'FU', N'testleague', CAST(N'2023-03-10T11:13:16.670' AS DateTime), N'A league with test able data, league type is league, 7 participate, 10 player per team, 7 player in squad', N'LEAGUE', 1, NULL, 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (7, 10, N'test15_03', 3, CAST(N'2023-03-15T02:34:45.360' AS DateTime), CAST(N'2023-03-16T02:34:45.360' AS DateTime), 7, 7, N'string', N'string', CAST(N'2023-03-15T09:35:22.387' AS DateTime), N'string', N'LEAGUE', 1, NULL, 0)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound], [Logo], [IsFinished]) VALUES (8, 4, N'Testable League (Type: KO)', 7, CAST(N'2023-03-14T17:00:00.000' AS DateTime), CAST(N'2023-03-16T17:00:00.000' AS DateTime), 12, 7, N'FU', N'ABC', CAST(N'2023-03-15T16:15:10.500' AS DateTime), N'League that can test with type is KO', N'KO', NULL, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FTestable%20League%20(Type%3A%20KO)%2Flogo%2F15-03-2023Logo_Real_Madrid.svg.png?alt=media&token=89aff65b-408d-4974-9f90-a1a9ce47304a', 0)
SET IDENTITY_INSERT [dbo].[League] OFF
GO
SET IDENTITY_INSERT [dbo].[LeagueFee] ON 

INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (1, 1, N'A', N'Gold Medal', 50000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (2, 1, N'B', N'Silver Medal', 25000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (3, 1, N'C', N'Bronze Medal', 15000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (4, 2, N'A', N'Gold Medal', 20000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (5, 2, N'B', N'Silver Medal', 10000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (6, 2, N'C', N'Bronze Medal', 5000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (7, 3, N'K0', N'Gold Medal', 5000000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (8, 3, N'K1', N'Silver Medal', 2500000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (9, 3, N'K2', N'Bronze Medal', 1000000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (10, 3, N'K3', N'Top Score', 200000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (11, 3, N'K4', N'Top assist', 200000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (12, 3, N'K5', N'Best Goal Keeper', 200000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (13, 3, N'K6', N'Field Fee', 300000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (14, 3, N'K7', N'Referee', 400000.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (15, 4, N'string', N'string', 0.0000, 0, N'Fee')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (16, 5, N'string', N'string', 0.0000, 0, N'Fee')
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
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (28, 7, N'F0', N'Sponsored', 0.0000, 0, N'Sponsored')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (29, 7, N'string', N'string', 0.0000, 0, N'Prize')
INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual], [FeeType]) VALUES (30, 7, N'Ff', N'string', 0.0000, 0, N'Fee')
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
SET IDENTITY_INSERT [dbo].[LeagueFee] OFF
GO
SET IDENTITY_INSERT [dbo].[Match] ON 

INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (1, 1, 2, 1, CAST(N'2023-03-15T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (2, 1, 3, 5, CAST(N'2023-03-13T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (3, 1, 7, 6, CAST(N'2023-03-13T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (4, 1, 9, 8, CAST(N'2023-03-11T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (5, 2, 11, 10, CAST(N'2023-02-28T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (6, 2, 13, 12, CAST(N'2023-02-28T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (7, 2, 15, 14, CAST(N'2023-02-28T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (8, 2, 16, 10, CAST(N'2023-03-02T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (9, 2, 13, 11, CAST(N'2023-03-02T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (10, 2, 14, 12, CAST(N'2023-03-02T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (11, 2, 13, 10, CAST(N'2023-03-04T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (12, 2, 15, 16, CAST(N'2023-03-04T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (13, 2, 14, 11, CAST(N'2023-03-04T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (14, 2, 15, 10, CAST(N'2023-03-06T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (15, 2, 14, 13, CAST(N'2023-03-06T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (16, 2, 12, 16, CAST(N'2023-03-06T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (17, 2, 14, 10, CAST(N'2023-03-08T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (18, 2, 12, 15, CAST(N'2023-03-08T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (19, 2, 11, 16, CAST(N'2023-03-08T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (20, 2, 12, 10, CAST(N'2023-03-10T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (21, 2, 11, 15, CAST(N'2023-03-10T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (22, 2, 16, 13, CAST(N'2023-03-10T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (23, 2, 11, 12, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (24, 2, 16, 14, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (25, 2, 13, 15, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (26, 3, 18, 17, CAST(N'2023-03-02T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (27, 3, 20, 19, CAST(N'2023-03-02T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (28, 3, 22, 21, CAST(N'2023-03-02T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (29, 3, 23, 17, CAST(N'2023-03-04T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (30, 3, 20, 18, CAST(N'2023-03-04T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (31, 3, 21, 19, CAST(N'2023-03-04T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (32, 3, 20, 17, CAST(N'2023-03-06T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (33, 3, 22, 23, CAST(N'2023-03-06T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (34, 3, 21, 18, CAST(N'2023-03-06T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (35, 3, 22, 17, CAST(N'2023-03-08T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (36, 3, 21, 20, CAST(N'2023-03-08T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (37, 3, 19, 23, CAST(N'2023-03-08T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (38, 3, 21, 17, CAST(N'2023-03-10T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (39, 3, 19, 22, CAST(N'2023-03-10T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (40, 3, 18, 23, CAST(N'2023-03-10T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (41, 3, 19, 17, CAST(N'2023-03-12T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (42, 3, 18, 22, CAST(N'2023-03-12T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (43, 3, 23, 20, CAST(N'2023-03-12T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (44, 3, 18, 19, CAST(N'2023-03-14T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (45, 3, 23, 21, CAST(N'2023-03-14T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (46, 3, 20, 22, CAST(N'2023-03-14T15:28:03.087' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (47, 4, 25, 24, CAST(N'2023-03-07T04:09:28.677' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (48, 4, 27, 26, CAST(N'2023-03-07T04:09:28.677' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (49, 4, 27, 24, CAST(N'2023-03-09T04:09:28.677' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (50, 4, 26, 25, CAST(N'2023-03-09T04:09:28.677' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (51, 4, 26, 24, CAST(N'2023-03-11T04:09:28.677' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (52, 4, 25, 27, CAST(N'2023-03-11T04:09:28.677' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (53, 5, 29, 28, CAST(N'2023-03-08T04:09:28.677' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (54, 5, 32, 31, CAST(N'2023-03-06T04:09:28.677' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (55, 5, 34, 33, CAST(N'2023-03-06T04:09:28.677' AS DateTime), 0, NULL, NULL)
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
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (77, 7, 43, 42, CAST(N'2023-03-15T02:34:45.360' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (78, 7, 44, 42, CAST(N'2023-03-17T02:34:45.360' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (79, 7, 43, 44, CAST(N'2023-03-19T02:34:45.360' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (80, 8, 46, 45, CAST(N'2023-03-16T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (81, 8, 48, 47, CAST(N'2023-03-14T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (82, 8, 49, 51, CAST(N'2023-03-14T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (83, 8, 53, 52, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (84, 8, 55, 54, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Match] ([MatchId], [LeagueId], [HomeId], [AwayId], [MatchDate], [IsFinish], [Round], [Stadium]) VALUES (85, 8, 57, 56, CAST(N'2023-03-12T17:00:00.000' AS DateTime), 0, NULL, NULL)
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
SET IDENTITY_INSERT [dbo].[MatchEvent] OFF
GO
SET IDENTITY_INSERT [dbo].[MatchStat] ON 

INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (1, 56, 1, 2, 2, 3, 2, 2, 1, 3, 3)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (2, 56, 0, 3, 4, 7, 8, 3, 2, 9, 2)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (3, 57, 1, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (4, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (5, 54, 1, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[MatchStat] ([MatchStatId], [MatchId], [IsHome], [Score], [Shot], [ShotOnTarget], [Conner], [Foul], [Offside], [YellowCard], [RedCard]) VALUES (6, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[MatchStat] OFF
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
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (35, 0, 28, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (36, 0, 29, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (37, 0, 34, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (38, 0, 31, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (39, 0, 33, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (40, 0, 32, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (41, 0, 30, 0, NULL, NULL, NULL, 6)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (42, 0, 35, 0, NULL, NULL, NULL, 7)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (43, 0, 36, 0, NULL, NULL, NULL, 7)
INSERT [dbo].[ParticipateNode] ([ParticipateNodeId], [ParticipateId], [ClubCloneId], [Deep], [ParentId], [LeftId], [RightId], [LeagueId]) VALUES (44, 0, 37, 0, NULL, NULL, NULL, 7)
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
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (17, 3, 9, N'Invite', N'Rejected', CAST(N'2023-03-02T22:36:50.133' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (18, 3, 8, N'Invite', N'Rejected', CAST(N'2023-03-02T22:37:13.033' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (19, 3, 7, N'Invite', N'Rejected', CAST(N'2023-03-02T22:37:15.320' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (20, 3, 6, N'Invite', N'Accepted', CAST(N'2023-03-02T22:37:17.557' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (21, 3, 4, N'Invite', N'Canceled', CAST(N'2023-03-02T22:37:20.007' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (22, 3, 13, N'Register', N'Accepted', CAST(N'2023-03-02T22:48:40.933' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (23, 3, 1, N'Invite', N'Pending', CAST(N'2023-03-05T22:32:59.707' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (24, 3, 14, N'Register', N'Canceled', CAST(N'2023-03-06T10:30:40.940' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (25, 1, 14, N'Register', N'Canceled', CAST(N'2023-03-06T12:23:20.640' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (26, 3, 2, N'Invite', N'Pending', CAST(N'2023-03-06T12:27:59.143' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (27, 1, 10, N'Register', N'Canceled', CAST(N'2023-03-06T15:53:34.280' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (28, 3, 10, N'Register', N'Accepted', CAST(N'2023-03-06T15:56:52.630' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (29, 4, 3, N'Invite', N'Accepted', CAST(N'2023-03-07T15:33:36.453' AS DateTime))
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
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (40, 5, 2, N'Invite', N'Accepted', CAST(N'2023-03-15T14:26:22.203' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (41, 8, 10, N'Invite', N'Accepted', CAST(N'2023-03-15T17:21:33.947' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (42, 8, 13, N'Invite', N'Accepted', CAST(N'2023-03-15T17:21:56.447' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (43, 8, 11, N'Invite', N'Accepted', CAST(N'2023-03-15T17:22:55.440' AS DateTime))
INSERT [dbo].[ParticipateRequest] ([RequestId], [LeagueId], [ClubId], [RequestType], [RequestStatus], [RequestDate]) VALUES (44, 8, 15, N'Register', N'Pending', CAST(N'2023-03-23T22:04:53.947' AS DateTime))
SET IDENTITY_INSERT [dbo].[ParticipateRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[Participation] ON 

INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (1, 1, 3, 0, NULL, CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (2, 1, 4, 0, NULL, CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (3, 2, 2, 0, NULL, CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (4, 2, 3, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (5, 3, 13, 1, N'evidence', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (6, 3, 11, 0, NULL, CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (7, 3, 12, 0, NULL, CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (8, 3, 10, 0, NULL, CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (9, 4, 3, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (10, 6, 13, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (11, 6, 12, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (12, 6, 10, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (13, 6, 11, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (14, 6, 7, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (15, 6, 5, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (16, 3, 6, 0, NULL, CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (17, 6, 4, 1, N'string', CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (18, 5, 2, 0, NULL, CAST(N'2023-03-15T14:26:41.360' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (19, 8, 10, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FTestable%20League%20(Type%3A%20KO)%2Fevidence%2FManchester%20United%2F15-03-2023Logo_Real_Madrid.svg.png?alt=media&token=99888094-e7e5-48f2-988d-88c146421ea7', CAST(N'2023-03-15T17:28:37.070' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (20, 8, 13, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FTestable%20League%20(Type%3A%20KO)%2Fevidence%2FBarcelona%2F24-03-2023channels4_profile.jpg?alt=media&token=df0571d6-3c59-4a00-bcdc-e20a910c9ba9', CAST(N'2023-03-15T17:28:54.970' AS DateTime))
INSERT [dbo].[Participation] ([ParticipationId], [LeagueId], [ClubId], [Confirmed], [evidence], [JoinDate]) VALUES (21, 8, 11, 1, N'https://firebasestorage.googleapis.com/v0/b/flms-3e6a8.appspot.com/o/league%2FTestable%20League%20(Type%3A%20KO)%2Fevidence%2FManchester%20City%2F28-03-2023channels4_profile.jpg?alt=media&token=c50c0fd5-afc0-451b-be52-b22d9386c9ca', CAST(N'2023-03-15T17:30:15.703' AS DateTime))
SET IDENTITY_INSERT [dbo].[Participation] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (2, N'Player 1', N'anh', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (3, N'Player 2', N'anh2', CAST(N'2023-02-27T14:55:15.383' AS DateTime), N'string', N'string', N'string', N'string', N'string', N'string', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (4, N'Ninh Duc Anh', N'ninhkhoai07', CAST(N'2001-06-20T17:00:00.000' AS DateTime), N'1m72', N'63kg', N'Long Bien', N'ninhducanh', N'ducanh2106@gmail.com', N'anhnd', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (5, N'Messiii', N'mes', CAST(N'2017-02-06T17:00:00.000' AS DateTime), N'1m69', N'70kg', N'Spain', N'aaaa', N'messi@gmail.com', N'messsiiii', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (6, N'Vinicius Jr', N'vjr', CAST(N'2000-03-07T17:00:00.000' AS DateTime), N'1m72', N'65kg', N'RM', N'aa', N'aaa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (7, N'Toni Kross', N'tkross', CAST(N'1997-03-02T17:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (8, N'COURTOIS', N'ct', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (9, N'CARVAJAL', N'aat', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (10, N'BENZEMA', N'ben', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (11, N'HAZARD', N'haz', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (12, N'ALABA', N'ala', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (13, N'NACHO', N'nac', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (14, N'VALVERDE', N'val', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (15, N'ASENSIO', N'ase', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (16, N'RODRYGO', N'rod', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'madrid', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (17, N'ter Stegen', N'steg', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (18, N'Marcos Alonso', N'mara', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (19, N'Jordi Alba', N'jor', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (20, N'Busquets', N'bus', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (21, N'Pedri', N'pedri', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (22, N'Frenkie De Jong', N'dejong', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (23, N'Gavi', N'gavi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (24, N'Raphinha', N'raphi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (25, N'Ferran Torres', N'ferran', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (26, N'Sergi Roberto', N'sergi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (27, N'Bruno Fernandes', N'bru', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (28, N'Harry Maguire', N'marguire', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (29, N'Aaron Wan-Bissaka', N'wansabi', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (30, N'Fred', N'fred', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (31, N'Eric Bailly', N'bally', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (32, N'Marcus Rashford', N'rash', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (33, N'Luke Shaw', N'shaw', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (34, N'Robin van Persie', N'rvp', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'barca', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (35, N'David de Gea', N'degea', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (36, N'Nani', N'nani', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (37, N'Cristiano Ronaldo', N'cr7', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (38, N'Ederson', N'ede', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mu', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (39, N'Dias', N'dias', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (40, N'Kyle Walker', N'kyle', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (41, N'John Stones', N'stones', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (42, N'Jack Grealish', N'jack', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (43, N'Rodri', N'rodri', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (44, N'Kevin De Bruyne', N'kevin', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (45, N'Bernardo Silva', N'silva', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (46, N'Phil Foden', N'phil', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (47, N'Erling Haaland', N'haaland', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (48, N'Riyad Mahrez', N'mahrez', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'mc', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (49, N'Alisson', N'alisson', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (50, N'Virgil van Dijk', N'vandijk', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (51, N'Ibrahima Konate', N'konate', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (52, N'Thiago', N'thiago', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (53, N'Diogo Jota', N'jota', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (54, N'Darwin Nunez', N'nunez', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
INSERT [dbo].[Player] ([PlayerId], [Name], [NickName], [Dob], [Height], [Weight], [Address], [PhoneNumber], [Email], [SocialCont], [Avatar]) VALUES (55, N'Fabio Carvalho', N'fabio', CAST(N'1997-03-02T00:00:00.000' AS DateTime), N'1m82', N'80kg', N'liver', N'aaa', N'aa@gmail.com', N'abc', NULL)
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
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
SET IDENTITY_INSERT [dbo].[PlayerClub] ON 

INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (1, 2, 4, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (2, 2, 3, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (3, 3, 3, 7)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (4, 4, 14, 8)
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (5, 5, 13, 10)
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
INSERT [dbo].[PlayerClub] ([PlayerClubId], [PlayerId], [ClubId], [Number]) VALUES (56, 110, 10, 9)
SET IDENTITY_INSERT [dbo].[PlayerClub] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshToken] ON 

INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (25, 7, N'gqozd1zJJMWsAB8KYFw0OK/gJPprPUIVdSQCEtocp3c=', N'3C4yiSJn09FOhmTbfj9iTydK2WGUgW7RiFAs+JxD/+4=', CAST(N'2023-02-03T21:24:00' AS SmallDateTime), CAST(N'2023-02-03T21:25:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (27, 8, N'o51/t8SukSEO0ziGTaZrlpRisSHbkvXRR7nnyUUHR7U=', N'lJJO9etrl5uaNj3YzwpK26NL1zphTlaax5UccFCdrSA=', CAST(N'2023-02-05T23:17:00' AS SmallDateTime), CAST(N'2023-02-05T23:18:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (97, 11, N'v9QEfKDz6kmFRoDrR2QTyhQppE5uS9VITfG3AMIssMA=', N'hfyuiM7DmP9DAZX851Jp4GiAeTVjILlC0EOlh2Gb8iI=', CAST(N'2023-03-01T10:11:00' AS SmallDateTime), CAST(N'2023-03-01T10:12:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (113, 17, N'RIEnyyq11vkEoZ4DGR0ukGJauPjpGEoy4Z6Zo5tmiO4=', N'L2LZO2SLTH8TGGc2/kUGtGln4ezZ3HVDfwvtu2xwSd0=', CAST(N'2023-03-02T21:47:00' AS SmallDateTime), CAST(N'2023-03-02T21:48:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (117, 20, N'k8O+OhhA5h+yVG2L7OXZ50tZDWIaOb/vSp01CyIZGxA=', N'VSgu4Pbj4TOnwu7Z3iIm6mBVGaaWTjlUBzJo5w5KPBc=', CAST(N'2023-03-02T22:16:00' AS SmallDateTime), CAST(N'2023-03-02T22:17:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (1183, 10, N'CpM/C6fckEbboYwpt+9H1tdpLJWcxBdsgxondl2uGr8=', N'L1/KSW1w3JCWyu6hT6qpIYV7CZfQIH68oGS4Fo03tGA=', CAST(N'2023-03-15T09:34:00' AS SmallDateTime), CAST(N'2023-03-15T09:35:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (1200, 4, N'nkDQQmoaRWONKRs4QsDaY+YmNJPK0/ppHjOykxRpKcs=', N'pUAuUljrWzAN25J7sS8LGL2AyQOiWqbcr77XyqR1Pu0=', CAST(N'2023-03-28T10:42:00' AS SmallDateTime), CAST(N'2023-03-28T10:43:00' AS SmallDateTime))
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
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (61, 77, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (62, 77, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (63, 78, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (64, 78, 0, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (65, 79, 1, 7)
INSERT [dbo].[Squad] ([SquadId], [MatchId], [IsHome], [NoPlayerSquad]) VALUES (66, 79, 0, 7)
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
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (16, 2, N'P1', 3)
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
GO
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
GO
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
GO
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
GO
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
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (673, 61, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (674, 61, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (675, 61, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (676, 61, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (677, 61, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (678, 61, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (679, 61, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (680, 62, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (681, 62, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (682, 62, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (683, 62, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (684, 62, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (685, 62, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (686, 62, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (687, 63, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (688, 63, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (689, 63, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (690, 63, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (691, 63, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (692, 63, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (693, 63, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (694, 64, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (695, 64, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (696, 64, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (697, 64, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (698, 64, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (699, 64, N'P6', NULL)
GO
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (700, 64, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (701, 65, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (702, 65, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (703, 65, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (704, 65, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (705, 65, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (706, 65, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (707, 65, N'P7', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (708, 66, N'P1', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (709, 66, N'P2', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (710, 66, N'P3', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (711, 66, N'P4', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (712, 66, N'P5', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (713, 66, N'P6', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (714, 66, N'P7', NULL)
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
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (794, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (795, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (796, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (797, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (798, 73, N'P0', NULL)
INSERT [dbo].[SquadPosition] ([SquadPositionId], [SquadId], [PositionKey], [PlayerId]) VALUES (799, 74, N'P1', NULL)
GO
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
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (21, N'anhndhe150329@fpt.edu.vn', N'SLZ2O5Tgs2GDedSoS/R0zhPAKPy0JqFEnDDh+eb2kMA=', N'Ob0yjUSswNee8L0OKhoaY6BKcsA6wUW+AZKn9eJEYdQ=', N'Duc Anh Club Manager aaaa', N'1234567890', N'Long Bien, Ha Noi', 1, CAST(N'2023-03-02T22:26:28.507' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (22, N'vunhatmai.mfc@gmail.com', N'KsThOHLx02rv2HzuLdMwS0K8i8rQ4GHILyg6jy7dzxA=', N'Pdv5E+ZuPl1iXG8F1Kc9HqPP0vdqoUX5pq6toYLSIxc=', N'Nhat Mai Vu', N'1234567890', N'Ba Dinh, Ha Noi', 1, CAST(N'2023-03-02T22:38:41.750' AS DateTime), N'CLUB_MANAGER', NULL)
INSERT [dbo].[User] ([UserId], [Email], [Password], [PasswordSalt], [FullName], [Phone], [Address], [Active], [CreateAt], [Role], [Avatar]) VALUES (23, N'ninhducanh216@gmail.com', N'O5Ad9Eyj4ajGrvQW88IDqjDy/eNLgzv3WKjUqGF6hLk=', N'8RDEAPqVC+FETjL4wKbcMRyyGX/r9K7tT5DhUw96Q2k=', N'Ninh Duc Anh', N'0915936216', N'Thuong Thanh, Long Bien, Ha Noi', 1, CAST(N'2023-03-02T23:33:20.610' AS DateTime), N'CLUB_MANAGER', NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
INSERT [HangFire].[Schema] ([Version]) VALUES (7)
GO
INSERT [HangFire].[Server] ([Id], [Data], [LastHeartbeat]) VALUES (N'laptop-0utuqb0l:16104:d4e0ee5e-7017-4fb3-881e-4dd702a66e9a', N'{"WorkerCount":20,"Queues":["default"],"StartedAt":"2023-03-28T03:44:54.8480168Z"}', CAST(N'2023-03-28T03:51:25.087' AS DateTime))
GO
/****** Object:  Index [IX_HangFire_AggregatedCounter_ExpireAt]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt] ON [HangFire].[AggregatedCounter]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Hash_ExpireAt]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Job_ExpireAt]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt] ON [HangFire].[Job]
(
	[ExpireAt] ASC
)
INCLUDE([StateName]) 
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_StateName]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName] ON [HangFire].[Job]
(
	[StateName] ASC
)
WHERE ([StateName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_List_ExpireAt]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Server_LastHeartbeat]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat] ON [HangFire].[Server]
(
	[LastHeartbeat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Set_ExpireAt]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt] ON [HangFire].[Set]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Set_Score]    Script Date: 3/28/2023 10:51:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Score] ON [HangFire].[Set]
(
	[Key] ASC,
	[Score] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
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
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
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
