USE [master]
GO
/****** Object:  Database [CinemaDB]    Script Date: 24. 12. 2020. 15:32:36 ******/
CREATE DATABASE [CinemaDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CinemaDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CinemaDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CinemaDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CinemaDB_log.ldf' , SIZE = 4202496KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CinemaDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CinemaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CinemaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CinemaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CinemaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CinemaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CinemaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CinemaDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CinemaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CinemaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CinemaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CinemaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CinemaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CinemaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CinemaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CinemaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CinemaDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CinemaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CinemaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CinemaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CinemaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CinemaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CinemaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CinemaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CinemaDB] SET RECOVERY FULL 
GO
ALTER DATABASE [CinemaDB] SET  MULTI_USER 
GO
ALTER DATABASE [CinemaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CinemaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CinemaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CinemaDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CinemaDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CinemaDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CinemaDB', N'ON'
GO
ALTER DATABASE [CinemaDB] SET QUERY_STORE = OFF
GO
USE [CinemaDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TotalCost]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_TotalCost](@trenutnaNarudzbaKey varchar(20))
returns float
as
begin

    declare @r float;
    SELECT @r = SUM([TN].[cijena])
    FROM dbo.Racun R, dbo.narudzba N,dbo.tipNarduzbe TN 
	WHERE R.narudzbaKey = N.narudzbaKey AND N.narudzbaTipId = TN.id
	AND R.narudzbaKey = @trenutnaNarudzbaKey;

    return @r;
end
GO
/****** Object:  Table [dbo].[dobnoOgranicenje]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dobnoOgranicenje](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[minGodina] [int] NOT NULL,
 CONSTRAINT [dobnoOgranicenje_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[naziv] [varchar](128) NOT NULL,
	[zanrId] [smallint] NOT NULL,
	[producent] [varchar](128) NULL,
	[datumIzdavanja] [date] NULL,
	[trajanjeUMinutama] [smallint] NULL,
	[dobnoOgranicenjeId] [tinyint] NULL,
	[je3D] [bit] NOT NULL,
	[jeSinhronizovan] [bit] NULL,
	[jeTitlovan] [bit] NOT NULL,
	[opis] [text] NULL,
	[procenatZarade] [int] NULL,
 CONSTRAINT [film_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[grad]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grad](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[ime] [varchar](100) NOT NULL,
	[postanskiBroj] [int] NULL,
	[pozivniBroj] [tinyint] NOT NULL,
	[brojStanovnika] [int] NOT NULL,
 CONSTRAINT [grad_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[karta]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[karta](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[filmId] [int] NOT NULL,
	[rezervacijaId] [int] NULL,
	[salaId] [smallint] NOT NULL,
	[cijena] [float] NOT NULL,
	[jeIskoristena] [bit] NULL,
	[vrijemePrikazivanja] [datetime] NOT NULL,
	[sjediste] [varchar](5) NULL,
 CONSTRAINT [karta_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[kino]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kino](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[gradId] [tinyint] NOT NULL,
	[aktivnoOd] [date] NOT NULL,
	[vrijemeOtvaranja] [tinyint] NOT NULL,
	[vrijemeZatvaranja] [tinyint] NOT NULL,
	[kontaktTelefon] [varchar](32) NOT NULL,
	[adresa] [varchar](128) NOT NULL,
	[brojSala] [int] NOT NULL,
 CONSTRAINT [kino_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[narudzba]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[narudzba](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[racunId] [int] NOT NULL,
	[tipNarudzbeId] [tinyint] NOT NULL,
	[datum] [date] NOT NULL,
 CONSTRAINT [PK_narudzba_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[racun]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[racun](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[kinoId] [smallint] NOT NULL,
	[kartaId] [bigint] NULL,
	[tipPlacanjaId] [tinyint] NOT NULL,
	[datum] [datetime] NOT NULL,
 CONSTRAINT [racun_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rezervacija]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rezervacija](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[kinoId] [smallint] NOT NULL,
	[filmId] [int] NOT NULL,
	[tipRezervacijeId] [tinyint] NOT NULL,
	[ime] [varchar](32) NOT NULL,
	[prezime] [varchar](32) NOT NULL,
	[kontaktTelefon] [varchar](32) NOT NULL,
	[adresa] [varchar](64) NULL,
	[jePlaceno] [bit] NOT NULL,
	[datum] [datetime] NOT NULL,
 CONSTRAINT [rezervacija_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sala]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sala](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[kinoId] [smallint] NOT NULL,
	[naziv] [varchar](32) NOT NULL,
	[kapacitet] [smallint] NOT NULL,
 CONSTRAINT [sala_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipNarduzbe]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipNarduzbe](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[naziv] [varchar](64) NOT NULL,
	[cijena] [float] NOT NULL,
	[opis] [varchar](128) NOT NULL,
	[datumDodavanja] [date] NOT NULL,
 CONSTRAINT [tipNarduzbe_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipPlacanja]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipPlacanja](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[naziv] [varchar](64) NULL,
	[sifra] [varchar](32) NOT NULL,
	[datumDodavanja] [date] NOT NULL,
 CONSTRAINT [tipPlacanja_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipRezervacije]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipRezervacije](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[naziv] [varchar](32) NULL,
	[sifra] [varchar](8) NOT NULL,
	[datumDodavanja] [date] NOT NULL,
 CONSTRAINT [tipRezervacije_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zanr]    Script Date: 24. 12. 2020. 15:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zanr](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[sifra] [varchar](32) NOT NULL,
	[naziv] [varchar](32) NULL,
 CONSTRAINT [zanr_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [narudzbaKey]    Script Date: 24. 12. 2020. 15:32:36 ******/
CREATE NONCLUSTERED INDEX [narudzbaKey] ON [dbo].[narudzba]
(
	[datum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [tipPlacanja_sifra_uindex]    Script Date: 24. 12. 2020. 15:32:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [tipPlacanja_sifra_uindex] ON [dbo].[tipPlacanja]
(
	[sifra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [tipRezervacije_sifra_uindex]    Script Date: 24. 12. 2020. 15:32:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [tipRezervacije_sifra_uindex] ON [dbo].[tipRezervacije]
(
	[sifra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [zanr_sifra_uindex]    Script Date: 24. 12. 2020. 15:32:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [zanr_sifra_uindex] ON [dbo].[zanr]
(
	[sifra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dobnoOgranicenje] ADD  DEFAULT ((0)) FOR [minGodina]
GO
ALTER TABLE [dbo].[film] ADD  CONSTRAINT [DF__film__je3D__2C3393D0]  DEFAULT ((0)) FOR [je3D]
GO
ALTER TABLE [dbo].[film] ADD  CONSTRAINT [DF__film__jeSinhroni__2D27B809]  DEFAULT ((0)) FOR [jeSinhronizovan]
GO
ALTER TABLE [dbo].[film] ADD  CONSTRAINT [DF__film__jeTitlovan__2E1BDC42]  DEFAULT ((0)) FOR [jeTitlovan]
GO
ALTER TABLE [dbo].[karta] ADD  CONSTRAINT [DF__karta__jeIskoris__3E52440B]  DEFAULT ((0)) FOR [jeIskoristena]
GO
ALTER TABLE [dbo].[rezervacija] ADD  CONSTRAINT [DF__rezervaci__jePla__5535A963]  DEFAULT ((0)) FOR [jePlaceno]
GO
ALTER TABLE [dbo].[film]  WITH CHECK ADD  CONSTRAINT [FK_Film_DobnoOgranicenje] FOREIGN KEY([dobnoOgranicenjeId])
REFERENCES [dbo].[dobnoOgranicenje] ([id])
GO
ALTER TABLE [dbo].[film] CHECK CONSTRAINT [FK_Film_DobnoOgranicenje]
GO
ALTER TABLE [dbo].[film]  WITH CHECK ADD  CONSTRAINT [FK_Film_Zanr] FOREIGN KEY([zanrId])
REFERENCES [dbo].[zanr] ([id])
GO
ALTER TABLE [dbo].[film] CHECK CONSTRAINT [FK_Film_Zanr]
GO
ALTER TABLE [dbo].[karta]  WITH CHECK ADD FOREIGN KEY([rezervacijaId])
REFERENCES [dbo].[rezervacija] ([id])
GO
ALTER TABLE [dbo].[karta]  WITH CHECK ADD FOREIGN KEY([salaId])
REFERENCES [dbo].[sala] ([id])
GO
ALTER TABLE [dbo].[karta]  WITH CHECK ADD  CONSTRAINT [FK_Karta_Film] FOREIGN KEY([filmId])
REFERENCES [dbo].[film] ([id])
GO
ALTER TABLE [dbo].[karta] CHECK CONSTRAINT [FK_Karta_Film]
GO
ALTER TABLE [dbo].[kino]  WITH CHECK ADD  CONSTRAINT [fk_kino_grad] FOREIGN KEY([gradId])
REFERENCES [dbo].[grad] ([id])
GO
ALTER TABLE [dbo].[kino] CHECK CONSTRAINT [fk_kino_grad]
GO
ALTER TABLE [dbo].[narudzba]  WITH CHECK ADD  CONSTRAINT [FK_narudzba_racun] FOREIGN KEY([racunId])
REFERENCES [dbo].[racun] ([id])
GO
ALTER TABLE [dbo].[narudzba] CHECK CONSTRAINT [FK_narudzba_racun]
GO
ALTER TABLE [dbo].[narudzba]  WITH CHECK ADD  CONSTRAINT [FK_Narudzba_TipNarudzbe] FOREIGN KEY([tipNarudzbeId])
REFERENCES [dbo].[tipNarduzbe] ([id])
GO
ALTER TABLE [dbo].[narudzba] CHECK CONSTRAINT [FK_Narudzba_TipNarudzbe]
GO
ALTER TABLE [dbo].[racun]  WITH CHECK ADD  CONSTRAINT [FK_Racun_Karta] FOREIGN KEY([kartaId])
REFERENCES [dbo].[karta] ([id])
GO
ALTER TABLE [dbo].[racun] CHECK CONSTRAINT [FK_Racun_Karta]
GO
ALTER TABLE [dbo].[racun]  WITH CHECK ADD  CONSTRAINT [FK_Racun_Kino] FOREIGN KEY([kinoId])
REFERENCES [dbo].[kino] ([id])
GO
ALTER TABLE [dbo].[racun] CHECK CONSTRAINT [FK_Racun_Kino]
GO
ALTER TABLE [dbo].[racun]  WITH CHECK ADD  CONSTRAINT [FK_Racun_TipPlacanja] FOREIGN KEY([tipPlacanjaId])
REFERENCES [dbo].[tipPlacanja] ([id])
GO
ALTER TABLE [dbo].[racun] CHECK CONSTRAINT [FK_Racun_TipPlacanja]
GO
ALTER TABLE [dbo].[rezervacija]  WITH NOCHECK ADD  CONSTRAINT [FK_Rezervacija_Film] FOREIGN KEY([filmId])
REFERENCES [dbo].[film] ([id])
GO
ALTER TABLE [dbo].[rezervacija] CHECK CONSTRAINT [FK_Rezervacija_Film]
GO
ALTER TABLE [dbo].[rezervacija]  WITH CHECK ADD  CONSTRAINT [FK_Rezervacija_Kino] FOREIGN KEY([kinoId])
REFERENCES [dbo].[kino] ([id])
GO
ALTER TABLE [dbo].[rezervacija] CHECK CONSTRAINT [FK_Rezervacija_Kino]
GO
ALTER TABLE [dbo].[rezervacija]  WITH CHECK ADD  CONSTRAINT [FK_Rezervacija_TipRezervacije] FOREIGN KEY([tipRezervacijeId])
REFERENCES [dbo].[tipRezervacije] ([id])
GO
ALTER TABLE [dbo].[rezervacija] CHECK CONSTRAINT [FK_Rezervacija_TipRezervacije]
GO
ALTER TABLE [dbo].[sala]  WITH CHECK ADD  CONSTRAINT [FK_Sala_Kino] FOREIGN KEY([kinoId])
REFERENCES [dbo].[kino] ([id])
GO
ALTER TABLE [dbo].[sala] CHECK CONSTRAINT [FK_Sala_Kino]
GO
USE [master]
GO
ALTER DATABASE [CinemaDB] SET  READ_WRITE 
GO
