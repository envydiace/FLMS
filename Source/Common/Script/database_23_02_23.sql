USE [master]
GO
/****** Object:  Database [FLMS_DB]    Script Date: 2/23/2023 9:51:03 PM ******/
CREATE DATABASE [FLMS_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FLMS_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER07\MSSQL\DATA\FLMS_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FLMS_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER07\MSSQL\DATA\FLMS_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE SQL_Latin1_General_CP1_CI_AS
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
/****** Object:  Table [dbo].[Club]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Club](
	[ClubId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ClubName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SocialCont] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreateAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClubId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClubLeague]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClubLeague](
	[ClubLeagueId] [int] IDENTITY(1,1) NOT NULL,
	[ClubName] [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ClubId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClubLeagueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[League]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[League](
	[LeagueId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[LeagueName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NoParticipate] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[MaxNoPlayer] [int] NOT NULL,
	[NoPlayerSquad] [int] NOT NULL,
	[Location] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fanpage] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreateAt] [datetime] NOT NULL,
	[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LeagueType] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NoRound] [int] NULL,
 CONSTRAINT [PK__League__10ABBCF4E505BDC3] PRIMARY KEY CLUSTERED 
(
	[LeagueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeagueFee]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeagueFee](
	[LeagueFeeId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ExpenseKey] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ExpenseName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Cost] [float] NOT NULL,
	[IsActual] [bit] NOT NULL,
 CONSTRAINT [PK__LeagueFe__3502577D95B2FF37] PRIMARY KEY CLUSTERED 
(
	[LeagueFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Match]    Script Date: 2/23/2023 9:51:04 PM ******/
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
/****** Object:  Table [dbo].[MatchEvent]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchEvent](
	[MatchEventId] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NOT NULL,
	[SupportId] [int] NULL,
	[MatchId] [int] NOT NULL,
	[EventType] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MatchEventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatchStat]    Script Date: 2/23/2023 9:51:04 PM ******/
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
/****** Object:  Table [dbo].[Participation]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participation](
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[PlayerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NickName] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Dob] [datetime] NULL,
	[Height] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Weight] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SocialCont] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerClub]    Script Date: 2/23/2023 9:51:04 PM ******/
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
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshToken](
	[TokenId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[TokenHash] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TokenSalt] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CreateAt] [smalldatetime] NOT NULL,
	[ExpiryDate] [smalldatetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TokenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[LeagueId] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
	[RequestType] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2/23/2023 9:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Password] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PasswordSalt] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Phone] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [bit] NOT NULL,
	[CreateAt] [datetime] NOT NULL,
	[Role] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
SET IDENTITY_INSERT [dbo].[League] ON 

INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (1, 10, N'string', 0, CAST(N'2023-02-22T08:47:43.503' AS DateTime), CAST(N'2023-02-22T08:47:43.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-22T08:47:43.503' AS DateTime), NULL, N'LEAGUE', NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (2, 10, N'string', 0, CAST(N'2023-02-22T08:47:43.503' AS DateTime), CAST(N'2023-02-22T08:47:43.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-22T08:47:43.503' AS DateTime), NULL, N'LEAGUE', NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (3, 10, N'string', 0, CAST(N'2023-02-22T08:47:43.503' AS DateTime), CAST(N'2023-02-22T08:47:43.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-22T08:47:43.503' AS DateTime), NULL, N'LEAGUE', NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (4, 10, N'string', 0, CAST(N'2023-02-22T08:47:43.503' AS DateTime), CAST(N'2023-02-22T08:47:43.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-22T15:54:14.363' AS DateTime), NULL, N'LEAGUE', NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (5, 10, N'string', 0, CAST(N'2023-02-22T08:47:43.503' AS DateTime), CAST(N'2023-02-22T08:47:43.503' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-22T15:54:23.047' AS DateTime), NULL, N'LEAGUE', NULL)
INSERT [dbo].[League] ([LeagueId], [UserId], [LeagueName], [NoParticipate], [StartDate], [EndDate], [MaxNoPlayer], [NoPlayerSquad], [Location], [Fanpage], [CreateAt], [Description], [LeagueType], [NoRound]) VALUES (6, 10, N'string', 0, CAST(N'2023-02-22T09:04:32.313' AS DateTime), CAST(N'2023-02-22T09:04:32.313' AS DateTime), 0, 0, N'string', N'string', CAST(N'2023-02-22T16:04:41.213' AS DateTime), NULL, N'LEAGUE', NULL)
SET IDENTITY_INSERT [dbo].[League] OFF
GO
SET IDENTITY_INSERT [dbo].[LeagueFee] ON 

INSERT [dbo].[LeagueFee] ([LeagueFeeId], [LeagueId], [ExpenseKey], [ExpenseName], [Cost], [IsActual]) VALUES (1, 6, N'string', N'string', 0, 0)
SET IDENTITY_INSERT [dbo].[LeagueFee] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshToken] ON 

INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (25, 7, N'gqozd1zJJMWsAB8KYFw0OK/gJPprPUIVdSQCEtocp3c=', N'3C4yiSJn09FOhmTbfj9iTydK2WGUgW7RiFAs+JxD/+4=', CAST(N'2023-02-03T21:24:00' AS SmallDateTime), CAST(N'2023-02-03T21:25:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (27, 8, N'o51/t8SukSEO0ziGTaZrlpRisSHbkvXRR7nnyUUHR7U=', N'lJJO9etrl5uaNj3YzwpK26NL1zphTlaax5UccFCdrSA=', CAST(N'2023-02-05T23:17:00' AS SmallDateTime), CAST(N'2023-02-05T23:18:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (52, 4, N'VqNGVkfMV35zYOl0dpMndhxTh3OX2R0Dg1bQ3bLKEbU=', N'agrHMqLT44+cUdlwGVhKa4gMSZI1D7lQNar1er2QxRA=', CAST(N'2023-02-18T22:32:00' AS SmallDateTime), CAST(N'2023-02-18T22:33:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (57, 9, N'YQXFrhT0wl9riS80+zf62ZcPBrFpVykZZUoTxI8REVg=', N'gByXnaL6UthN21F19bnIHZPvB5mQyocpSzQL1rPzkw8=', CAST(N'2023-02-21T15:38:00' AS SmallDateTime), CAST(N'2023-02-21T15:39:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([TokenId], [UserId], [TokenHash], [TokenSalt], [CreateAt], [ExpiryDate]) VALUES (62, 10, N'rDOzTbAhJwwNrUT+ko3t0H+i2avAgVsZg59ZmAhAQ84=', N'RAW///FfzcufABIzmTTGQkr5MKV4rcncCCyJx2Ucbjk=', CAST(N'2023-02-22T17:41:00' AS SmallDateTime), CAST(N'2023-02-22T17:42:00' AS SmallDateTime))
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
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([AwayId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD FOREIGN KEY([HomeId])
REFERENCES [dbo].[Club] ([ClubId])
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK__Match__LeagueId__44FF419A] FOREIGN KEY([LeagueId])
REFERENCES [dbo].[League] ([LeagueId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK__Match__LeagueId__44FF419A]
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
