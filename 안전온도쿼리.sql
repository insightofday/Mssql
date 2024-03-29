USE []
GO
/****** Object:  Table [dbo].[Mt_SetTemper]    Script Date: 2024-03-12 오전 10:13:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mt_SetTemper](
	[wTempA] [numeric](8, 1) NOT NULL,
	[wTempB] [numeric](8, 1) NOT NULL,
	[wTempC] [numeric](8, 1) NOT NULL,
 CONSTRAINT [PK_Mt_SetTemper] PRIMARY KEY CLUSTERED 
(
	[wTempA] ASC,
	[wTempB] ASC,
	[wTempC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Mt_SetTemper] ([wTempA], [wTempB], [wTempC]) VALUES (CAST(1.5 AS Numeric(8, 1)), CAST(1.1 AS Numeric(8, 1)), CAST(123.0 AS Numeric(8, 1)))
