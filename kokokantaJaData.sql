USE [master]
GO
/****** Object:  Database [Vuokraus]    Script Date: 9/29/2021 11:27:18 AM ******/
CREATE DATABASE [Vuokraus]
 CONTAINMENT = NONE
 -- JOS KOPIOIT TOISEEN KONEESEEN TARKISTA DATAHAKEMISTON POLKU!
 ON  PRIMARY 
( NAME = N'Vuokraus', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Vuokraus.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Vuokraus_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Vuokraus_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Vuokraus] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Vuokraus].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Vuokraus] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Vuokraus] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Vuokraus] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Vuokraus] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Vuokraus] SET ARITHABORT OFF 
GO
ALTER DATABASE [Vuokraus] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Vuokraus] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Vuokraus] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Vuokraus] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Vuokraus] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Vuokraus] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Vuokraus] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Vuokraus] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Vuokraus] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Vuokraus] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Vuokraus] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Vuokraus] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Vuokraus] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Vuokraus] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Vuokraus] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Vuokraus] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Vuokraus] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Vuokraus] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Vuokraus] SET  MULTI_USER 
GO
ALTER DATABASE [Vuokraus] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Vuokraus] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Vuokraus] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Vuokraus] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Vuokraus] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Vuokraus] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Vuokraus] SET QUERY_STORE = OFF
GO
USE [Vuokraus]
GO
/****** Object:  Table [dbo].[tuote]    Script Date: 9/29/2021 11:27:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tuote](
	[yksilointikoodi] [int] IDENTITY(1,1) NOT NULL,
	[tuoteryhma] [nvarchar](20) NOT NULL,
	[nimike] [nvarchar](40) NOT NULL,
	[merkki] [nvarchar](20) NOT NULL,
	[malli] [nvarchar](20) NOT NULL,
	[paivavuokra] [float] NOT NULL,
 CONSTRAINT [tuote_pk] PRIMARY KEY CLUSTERED 
(
	[yksilointikoodi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[asiakas]    Script Date: 9/29/2021 11:27:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asiakas](
	[asiakasnumero] [int] IDENTITY(1,1) NOT NULL,
	[yritys] [nvarchar](30) NOT NULL,
	[laskutusosoite] [nvarchar](30) NOT NULL,
	[postinumero] [nvarchar](10) NOT NULL,
	[postitoimipaikka] [nvarchar](30) NOT NULL,
 CONSTRAINT [asiakas_pk] PRIMARY KEY CLUSTERED 
(
	[asiakasnumero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vuokraus]    Script Date: 9/29/2021 11:27:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vuokraus](
	[tapahtuma_id] [int] IDENTITY(1,1) NOT NULL,
	[alkamispaiva] [datetime] NOT NULL,
	[paattymispaiva] [datetime] NOT NULL,
	[asiakasnumero] [int] NOT NULL,
	[yksilointikoodi] [int] NOT NULL,
 CONSTRAINT [vuokraus_pk] PRIMARY KEY CLUSTERED 
(
	[tapahtuma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vuokraukset]    Script Date: 9/29/2021 11:27:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vuokraukset]
AS
SELECT        dbo.asiakas.yritys, dbo.tuote.nimike, dbo.tuote.merkki, dbo.tuote.malli, dbo.tuote.paivavuokra, dbo.vuokraus.paattymispaiva, DATEDIFF(day, dbo.vuokraus.alkamispaiva, dbo.vuokraus.paattymispaiva) AS päiviä
FROM            dbo.asiakas INNER JOIN
                         dbo.vuokraus ON dbo.asiakas.asiakasnumero = dbo.vuokraus.asiakasnumero INNER JOIN
                         dbo.tuote ON dbo.vuokraus.yksilointikoodi = dbo.tuote.yksilointikoodi
GO
/****** Object:  Table [dbo].[tuoteryhma]    Script Date: 9/29/2021 11:27:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tuoteryhma](
	[tuoteryhma] [nvarchar](20) NOT NULL,
 CONSTRAINT [tuoteryhma_pk] PRIMARY KEY CLUSTERED 
(
	[tuoteryhma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[yhteyshenkilo]    Script Date: 9/29/2021 11:27:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[yhteyshenkilo](
	[yhteyshenkilo_id] [int] IDENTITY(1,1) NOT NULL,
	[yhteystyyppi] [nvarchar](20) NOT NULL,
	[etunimi] [nvarchar](20) NOT NULL,
	[sukunimi] [nvarchar](30) NOT NULL,
	[puhelin] [nvarchar](15) NULL,
	[sahkoposti] [nvarchar](40) NOT NULL,
	[asiakasnumero] [int] NOT NULL,
 CONSTRAINT [yhteyshenkilo_pk] PRIMARY KEY CLUSTERED 
(
	[yhteyshenkilo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[yhteystyyppi]    Script Date: 9/29/2021 11:27:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[yhteystyyppi](
	[yhteystyyppi] [nvarchar](20) NOT NULL,
 CONSTRAINT [yhteystyyppi_pk] PRIMARY KEY CLUSTERED 
(
	[yhteystyyppi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[asiakas] ON 

INSERT [dbo].[asiakas] ([asiakasnumero], [yritys], [laskutusosoite], [postinumero], [postitoimipaikka]) VALUES (1, N'Raseko', N'Purokatu 1', N'21200', N'Raisio')
INSERT [dbo].[asiakas] ([asiakasnumero], [yritys], [laskutusosoite], [postinumero], [postitoimipaikka]) VALUES (2, N'Autoliike', N'Keskuskatu 3', N'23100', N'Mynämäki')
INSERT [dbo].[asiakas] ([asiakasnumero], [yritys], [laskutusosoite], [postinumero], [postitoimipaikka]) VALUES (3, N'Mähönen Oy', N'Kuormakatu 2', N'21200', N'Raisio')
INSERT [dbo].[asiakas] ([asiakasnumero], [yritys], [laskutusosoite], [postinumero], [postitoimipaikka]) VALUES (4, N'Huttu ja keitto Ay', N'Puoskarinkatu 2 A 11', N'20100', N'Turku')
SET IDENTITY_INSERT [dbo].[asiakas] OFF
GO
SET IDENTITY_INSERT [dbo].[tuote] ON 

INSERT [dbo].[tuote] ([yksilointikoodi], [tuoteryhma], [nimike], [merkki], [malli], [paivavuokra]) VALUES (1, N'Sähkötyökalut', N'Akkuporakone', N'Bosch', N'GX120', 8)
INSERT [dbo].[tuote] ([yksilointikoodi], [tuoteryhma], [nimike], [merkki], [malli], [paivavuokra]) VALUES (2, N'Nostimet', N'Henkilönostin', N'Dino', N'1200', 60)
INSERT [dbo].[tuote] ([yksilointikoodi], [tuoteryhma], [nimike], [merkki], [malli], [paivavuokra]) VALUES (3, N'Telineet', N'Taso', N'Pro', N'100 x 300', 3)
INSERT [dbo].[tuote] ([yksilointikoodi], [tuoteryhma], [nimike], [merkki], [malli], [paivavuokra]) VALUES (4, N'Sähkötyökalut', N'Poravasara', N'Kangoo', N'G349', 10)
SET IDENTITY_INSERT [dbo].[tuote] OFF
GO
INSERT [dbo].[tuoteryhma] ([tuoteryhma]) VALUES (N'Nostimet')
INSERT [dbo].[tuoteryhma] ([tuoteryhma]) VALUES (N'Sähkötyökalut')
INSERT [dbo].[tuoteryhma] ([tuoteryhma]) VALUES (N'Telineet')
GO
SET IDENTITY_INSERT [dbo].[vuokraus] ON 

INSERT [dbo].[vuokraus] ([tapahtuma_id], [alkamispaiva], [paattymispaiva], [asiakasnumero], [yksilointikoodi]) VALUES (3, CAST(N'2021-09-15T00:00:00.000' AS DateTime), CAST(N'2021-09-22T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[vuokraus] ([tapahtuma_id], [alkamispaiva], [paattymispaiva], [asiakasnumero], [yksilointikoodi]) VALUES (4, CAST(N'2021-09-16T00:00:00.000' AS DateTime), CAST(N'2021-09-17T00:00:00.000' AS DateTime), 2, 1)
SET IDENTITY_INSERT [dbo].[vuokraus] OFF
GO
SET IDENTITY_INSERT [dbo].[yhteyshenkilo] ON 

INSERT [dbo].[yhteyshenkilo] ([yhteyshenkilo_id], [yhteystyyppi], [etunimi], [sukunimi], [puhelin], [sahkoposti], [asiakasnumero]) VALUES (2, N'Laskutus', N'Mikko', N'Karilainen', N'0453400422', N'mikko.kari@gmail.com', 1)
INSERT [dbo].[yhteyshenkilo] ([yhteyshenkilo_id], [yhteystyyppi], [etunimi], [sukunimi], [puhelin], [sahkoposti], [asiakasnumero]) VALUES (3, N'Toimitus', N'Niklas', N'Kauppila', N'0453400433', N'nikke@gmail.com', 1)
SET IDENTITY_INSERT [dbo].[yhteyshenkilo] OFF
GO
INSERT [dbo].[yhteystyyppi] ([yhteystyyppi]) VALUES (N'Laskutus')
INSERT [dbo].[yhteystyyppi] ([yhteystyyppi]) VALUES (N'Toimitus')
GO
ALTER TABLE [dbo].[tuote]  WITH CHECK ADD  CONSTRAINT [tuoteryhma_tuote_fk] FOREIGN KEY([tuoteryhma])
REFERENCES [dbo].[tuoteryhma] ([tuoteryhma])
GO
ALTER TABLE [dbo].[tuote] CHECK CONSTRAINT [tuoteryhma_tuote_fk]
GO
ALTER TABLE [dbo].[vuokraus]  WITH CHECK ADD  CONSTRAINT [asiakas_vuokraus_fk] FOREIGN KEY([asiakasnumero])
REFERENCES [dbo].[asiakas] ([asiakasnumero])
GO
ALTER TABLE [dbo].[vuokraus] CHECK CONSTRAINT [asiakas_vuokraus_fk]
GO
ALTER TABLE [dbo].[vuokraus]  WITH CHECK ADD  CONSTRAINT [tuote_vuokraus_fk] FOREIGN KEY([yksilointikoodi])
REFERENCES [dbo].[tuote] ([yksilointikoodi])
GO
ALTER TABLE [dbo].[vuokraus] CHECK CONSTRAINT [tuote_vuokraus_fk]
GO
ALTER TABLE [dbo].[yhteyshenkilo]  WITH CHECK ADD  CONSTRAINT [asiakas_yhteyshenkilo_fk] FOREIGN KEY([asiakasnumero])
REFERENCES [dbo].[asiakas] ([asiakasnumero])
GO
ALTER TABLE [dbo].[yhteyshenkilo] CHECK CONSTRAINT [asiakas_yhteyshenkilo_fk]
GO
ALTER TABLE [dbo].[yhteyshenkilo]  WITH CHECK ADD  CONSTRAINT [yhteystyyppi_yhteyshenkilo_fk] FOREIGN KEY([yhteystyyppi])
REFERENCES [dbo].[yhteystyyppi] ([yhteystyyppi])
GO
ALTER TABLE [dbo].[yhteyshenkilo] CHECK CONSTRAINT [yhteystyyppi_yhteyshenkilo_fk]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[30] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "asiakas"
            Begin Extent = 
               Top = 56
               Left = 37
               Bottom = 234
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tuote"
            Begin Extent = 
               Top = 73
               Left = 777
               Bottom = 270
               Right = 1031
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vuokraus"
            Begin Extent = 
               Top = 5
               Left = 394
               Bottom = 180
               Right = 639
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 6465
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vuokraukset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vuokraukset'
GO
USE [master]
GO
ALTER DATABASE [Vuokraus] SET  READ_WRITE 
GO
