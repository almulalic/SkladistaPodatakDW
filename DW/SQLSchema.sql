USE [master]
GO
/****** Object:  Database [CinemaDW]    Script Date: 24. 12. 2020. 15:31:13 ******/
CREATE DATABASE [CinemaDW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CinemaDW', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CinemaDW.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CinemaDW_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CinemaDW_log.ldf' , SIZE = 532480KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CinemaDW] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CinemaDW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CinemaDW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CinemaDW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CinemaDW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CinemaDW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CinemaDW] SET ARITHABORT OFF 
GO
ALTER DATABASE [CinemaDW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CinemaDW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CinemaDW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CinemaDW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CinemaDW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CinemaDW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CinemaDW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CinemaDW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CinemaDW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CinemaDW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CinemaDW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CinemaDW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CinemaDW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CinemaDW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CinemaDW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CinemaDW] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CinemaDW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CinemaDW] SET RECOVERY FULL 
GO
ALTER DATABASE [CinemaDW] SET  MULTI_USER 
GO
ALTER DATABASE [CinemaDW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CinemaDW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CinemaDW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CinemaDW] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CinemaDW] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CinemaDW] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CinemaDW', N'ON'
GO
ALTER DATABASE [CinemaDW] SET QUERY_STORE = OFF
GO
USE [CinemaDW]
GO
/****** Object:  Table [dbo].[Dim_Datum]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Datum](
	[id] [int] NOT NULL,
	[datum] [date] NOT NULL,
	[dan] [int] NOT NULL,
	[imeDana] [varchar](20) NOT NULL,
	[danSkraceno] [varchar](5) NOT NULL,
	[danUSedmici] [int] NOT NULL,
	[danUTromjesecu] [int] NOT NULL,
	[danUGodini] [int] NOT NULL,
	[sedmica] [int] NOT NULL,
	[mjesec] [int] NOT NULL,
	[imeMjeseca] [varchar](20) NOT NULL,
	[kvartal] [int] NOT NULL,
	[godina] [int] NOT NULL,
 CONSTRAINT [PK_Dim_Datum] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Film]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Film](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[filmAltKey] [int] NOT NULL,
	[zanrSifra] [varchar](32) NOT NULL,
	[zanrNaziv] [varchar](32) NOT NULL,
	[naziv] [varchar](128) NOT NULL,
	[trajanjeUMinutama] [int] NOT NULL,
	[minimumGodina] [int] NOT NULL,
	[je3D] [bit] NOT NULL,
	[jeSinhronizovan] [bit] NOT NULL,
	[jeTitlovan] [bit] NOT NULL,
	[procenatZarade] [int] NOT NULL,
	[procenatTroska] [int] NOT NULL,
 CONSTRAINT [PK__Dim_Film__3213E83FC5056B9F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Grad]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Grad](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[gradAltKey] [nchar](10) NULL,
	[ime] [varchar](100) NOT NULL,
	[postanskiBroj] [int] NOT NULL,
	[pozivniBroj] [tinyint] NOT NULL,
	[brojStanovnika] [int] NOT NULL,
 CONSTRAINT [PK_Dim_Grad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Karta]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Karta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[kartaAltKey] [int] NOT NULL,
	[jeIskoristena] [bit] NOT NULL,
	[salaNaziv] [varchar](32) NOT NULL,
	[jeNocnaProjekacija] [bit] NOT NULL,
	[jeRezervisana] [bit] NOT NULL,
 CONSTRAINT [PK__Dim_Kart__3213E83F92F997BD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_KinoLokacija]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_KinoLokacija](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[kinoAltKey] [int] NOT NULL,
	[gradNaziv] [varchar](100) NOT NULL,
	[gradPostanskiBroj] [int] NOT NULL,
	[gradBrojStanovnika] [int] NOT NULL,
	[cijeliKontaktTelefon] [varchar](50) NOT NULL,
	[vrijemeOtvaranja] [int] NOT NULL,
	[vrijemeZatvaranja] [int] NOT NULL,
	[radnoVrijemeUSatima] [int] NOT NULL,
	[brojSala] [int] NOT NULL,
 CONSTRAINT [PK_Dim_Kino] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_KinoRating]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_KinoRating](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[makismalnaOcjena] [int] NOT NULL,
	[minimalnaOcjena] [int] NOT NULL,
 CONSTRAINT [PK_Dim_KinoRating] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Sala]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Sala](
	[id] [int] NOT NULL,
	[salaAltKey] [int] NULL,
	[naziv] [varchar](32) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_TipNarudzbe]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_TipNarudzbe](
	[id] [int] NOT NULL,
	[tipNarudzbeAltKey] [nchar](10) NULL,
	[naziv] [varchar](64) NOT NULL,
	[cijena] [float] NOT NULL,
	[nabavnaCijena] [float] NOT NULL,
	[opis] [varchar](128) NOT NULL,
	[datumDodavanja] [date] NOT NULL,
 CONSTRAINT [PK_Dim_TipNarudzbe] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_TipPlacanja]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_TipPlacanja](
	[id] [int] NOT NULL,
	[naziv] [varchar](64) NOT NULL,
	[sifra] [varchar](32) NOT NULL,
	[datumDodavanja] [date] NOT NULL,
 CONSTRAINT [PK_Dim_TipPlacanja] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_KinoProdaja]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_KinoProdaja](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[gradKey] [int] NOT NULL,
	[tipNarudzbeKey] [int] NOT NULL,
	[ratingKey] [int] NOT NULL,
	[datumKey] [int] NOT NULL,
	[salaKey] [int] NOT NULL,
	[tipPlacanjaKey] [int] NULL,
	[ukupnoPordanoKarti] [int] NOT NULL,
	[ukupnaCijenaKarti] [float] NOT NULL,
	[prihodiOdKarata] [float] NOT NULL,
	[ukupnoIzdanoRacuna] [int] NOT NULL,
	[ukupnoNarudzbi] [int] NOT NULL,
	[ukupnaCijenaNarudzbi] [int] NOT NULL,
	[prihodiOdNarudzbi] [int] NOT NULL,
	[ukupnoFilmova] [int] NOT NULL,
	[prosjecniProcenatZaradePoFilmu] [int] NOT NULL,
	[brojNeiskoristenihKarti] [int] NOT NULL,
	[salaSaNajvecomPosjecenosti] [int] NOT NULL,
	[prosjecnoNarudzbiPoOsobi] [int] NOT NULL,
	[ukupnoRezervacija] [int] NOT NULL,
	[ukupnoUnikatnihRezervacija] [int] NOT NULL,
	[ukupnoUnaprijedPlacenihRezervacija] [int] NOT NULL,
	[prihodiOdRezervacija] [int] NOT NULL,
	[najcesciTipRezervacije] [int] NOT NULL,
	[filmSaNajviseRezervacija] [int] NOT NULL,
	[najcesciTipNarudzbe] [int] NOT NULL,
	[najcesciTipPlacanja] [int] NOT NULL,
	[najrjedjiTipRezervacije] [int] NOT NULL,
	[najrjedjiTipPlacanja] [int] NOT NULL,
	[najrjedjiTipNarudzbe] [int] NOT NULL,
	[ukupnoGlasova] [int] NOT NULL,
	[prosjecnaOcjenaKina] [int] NOT NULL,
	[prosjecnaOcjenaUsluge] [int] NOT NULL,
 CONSTRAINT [PK_Fact_Kino] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Racun]    Script Date: 24. 12. 2020. 15:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Racun](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[kartaKey] [int] NOT NULL,
	[datumKey] [int] NOT NULL,
	[kinoKey] [int] NOT NULL,
	[filmKey] [int] NOT NULL,
	[tipPlacanjaKey] [int] NOT NULL,
	[racunAltKey] [int] NOT NULL,
	[ukupnoNarudzbi] [int] NOT NULL,
	[ukupnaCijenaNarudzbi] [int] NOT NULL,
	[cijenaKarte] [int] NOT NULL,
	[ukupnaCijena] [int] NOT NULL,
 CONSTRAINT [PK_Fact_Racun] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Fact_KinoProdaja]  WITH CHECK ADD  CONSTRAINT [FK_FactKinoProdaja_DimDatum] FOREIGN KEY([datumKey])
REFERENCES [dbo].[Dim_Datum] ([id])
GO
ALTER TABLE [dbo].[Fact_KinoProdaja] CHECK CONSTRAINT [FK_FactKinoProdaja_DimDatum]
GO
ALTER TABLE [dbo].[Fact_KinoProdaja]  WITH CHECK ADD  CONSTRAINT [FK_FactKinoProdaja_DimGrad] FOREIGN KEY([gradKey])
REFERENCES [dbo].[Dim_Grad] ([id])
GO
ALTER TABLE [dbo].[Fact_KinoProdaja] CHECK CONSTRAINT [FK_FactKinoProdaja_DimGrad]
GO
ALTER TABLE [dbo].[Fact_KinoProdaja]  WITH CHECK ADD  CONSTRAINT [fk_FactKinoProdaja_DimSala] FOREIGN KEY([salaKey])
REFERENCES [dbo].[Dim_Sala] ([id])
GO
ALTER TABLE [dbo].[Fact_KinoProdaja] CHECK CONSTRAINT [fk_FactKinoProdaja_DimSala]
GO
ALTER TABLE [dbo].[Fact_KinoProdaja]  WITH CHECK ADD  CONSTRAINT [FK_FactKinoProdaja_DimTipNarudzbe] FOREIGN KEY([tipNarudzbeKey])
REFERENCES [dbo].[Dim_TipNarudzbe] ([id])
GO
ALTER TABLE [dbo].[Fact_KinoProdaja] CHECK CONSTRAINT [FK_FactKinoProdaja_DimTipNarudzbe]
GO
ALTER TABLE [dbo].[Fact_KinoProdaja]  WITH CHECK ADD  CONSTRAINT [FK_FactKinoProdaja_DimTipPlacanja] FOREIGN KEY([tipPlacanjaKey])
REFERENCES [dbo].[Dim_TipPlacanja] ([id])
GO
ALTER TABLE [dbo].[Fact_KinoProdaja] CHECK CONSTRAINT [FK_FactKinoProdaja_DimTipPlacanja]
GO
ALTER TABLE [dbo].[Fact_KinoProdaja]  WITH CHECK ADD  CONSTRAINT [FK_FactKinoRating_DimKinoRating] FOREIGN KEY([ratingKey])
REFERENCES [dbo].[Dim_KinoRating] ([id])
GO
ALTER TABLE [dbo].[Fact_KinoProdaja] CHECK CONSTRAINT [FK_FactKinoRating_DimKinoRating]
GO
ALTER TABLE [dbo].[Fact_Racun]  WITH CHECK ADD  CONSTRAINT [FK_FactRacun_DimDatum] FOREIGN KEY([datumKey])
REFERENCES [dbo].[Dim_Datum] ([id])
GO
ALTER TABLE [dbo].[Fact_Racun] CHECK CONSTRAINT [FK_FactRacun_DimDatum]
GO
ALTER TABLE [dbo].[Fact_Racun]  WITH CHECK ADD  CONSTRAINT [FK_FactRacun_DimFilm] FOREIGN KEY([filmKey])
REFERENCES [dbo].[Dim_Film] ([id])
GO
ALTER TABLE [dbo].[Fact_Racun] CHECK CONSTRAINT [FK_FactRacun_DimFilm]
GO
ALTER TABLE [dbo].[Fact_Racun]  WITH CHECK ADD  CONSTRAINT [FK_FactRacun_DimKarta] FOREIGN KEY([kartaKey])
REFERENCES [dbo].[Dim_Karta] ([id])
GO
ALTER TABLE [dbo].[Fact_Racun] CHECK CONSTRAINT [FK_FactRacun_DimKarta]
GO
ALTER TABLE [dbo].[Fact_Racun]  WITH CHECK ADD  CONSTRAINT [FK_FactRacun_DimKino] FOREIGN KEY([kinoKey])
REFERENCES [dbo].[Dim_KinoLokacija] ([id])
GO
ALTER TABLE [dbo].[Fact_Racun] CHECK CONSTRAINT [FK_FactRacun_DimKino]
GO
ALTER TABLE [dbo].[Fact_Racun]  WITH CHECK ADD  CONSTRAINT [FK_FactRacun_DimTipPlacanja] FOREIGN KEY([tipPlacanjaKey])
REFERENCES [dbo].[Dim_TipPlacanja] ([id])
GO
ALTER TABLE [dbo].[Fact_Racun] CHECK CONSTRAINT [FK_FactRacun_DimTipPlacanja]
GO
USE [master]
GO
ALTER DATABASE [CinemaDW] SET  READ_WRITE 
GO
