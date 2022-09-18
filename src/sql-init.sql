CREATE DATABASE gadget;

GO
USE gadget;
GO

CREATE TABLE [dbo].[Categories] (
    [CategoryId]  INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (MAX) NULL,
    [Description] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
);


GO

CREATE TABLE [dbo].[Products] (
    [ProductId]     INT             IDENTITY (1, 1) NOT NULL,
    [CategoryId]    INT             NOT NULL,
    [Name]          NVARCHAR (255)  NOT NULL,
    [Price]         DECIMAL (18, 2) NOT NULL,
    [ProductArtUrl] NVARCHAR (1024) NULL,
    CONSTRAINT [PK_dbo.Products] PRIMARY KEY CLUSTERED ([ProductId] ASC),
    CONSTRAINT [FK_dbo.Products_dbo.Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_CategoryId]
    ON [dbo].[Products]([CategoryId] ASC);


GO

CREATE TABLE [dbo].[Carts] (
    [RecordId]    INT            IDENTITY (1, 1) NOT NULL,
    [CartId]      NVARCHAR (MAX) NULL,
    [Count]       INT            NOT NULL,
    [DateCreated] DATETIME       NOT NULL,
    [ProductId]   INT            NOT NULL,
    CONSTRAINT [PK_dbo.Carts] PRIMARY KEY CLUSTERED ([RecordId] ASC),
    CONSTRAINT [FK_dbo.Carts_dbo.Products_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_ProductId]
    ON [dbo].[Carts]([ProductId] ASC);

GO


CREATE TABLE [dbo].[Orders] (
    [OrderId]    INT             IDENTITY (1, 1) NOT NULL,
    [OrderDate]  DATETIME        NOT NULL,
    [Username]   NVARCHAR (MAX)  NULL,
    [FirstName]  NVARCHAR (160)  NOT NULL,
    [LastName]   NVARCHAR (160)  NOT NULL,
    [Address]    NVARCHAR (70)   NOT NULL,
    [City]       NVARCHAR (40)   NOT NULL,
    [State]      NVARCHAR (40)   NOT NULL,
    [PostalCode] NVARCHAR (10)   NOT NULL,
    [Country]    NVARCHAR (40)   NOT NULL,
    [Phone]      NVARCHAR (24)   NOT NULL,
    [Email]      NVARCHAR (MAX)  NOT NULL,
    [Total]      DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [PK_dbo.Orders] PRIMARY KEY CLUSTERED ([OrderId] ASC)
);


GO

CREATE TABLE [dbo].[OrderDetails] (
    [OrderDetailId] INT             IDENTITY (1, 1) NOT NULL,
    [OrderId]       INT             NOT NULL,
    [ProductId]     INT             NOT NULL,
    [Quantity]      INT             NOT NULL,
    [UnitPrice]     DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [PK_dbo.OrderDetails] PRIMARY KEY CLUSTERED ([OrderDetailId] ASC),
    CONSTRAINT [FK_dbo.OrderDetails_dbo.Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([OrderId]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.OrderDetails_dbo.Products_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_OrderId]
    ON [dbo].[OrderDetails]([OrderId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ProductId]
    ON [dbo].[OrderDetails]([ProductId] ASC);



GO

SET IDENTITY_INSERT dbo.Categories ON 
GO

INSERT INTO Categories(CategoryId,Name,Description)
VALUES(1,'Mobile Phones','Latest collection of Mobile Phones'),
(2,'Laptops','Latest Laptops in 2022'),
(3,'Desktops','Latest Desktops in 2022'),
(4,'Audio','Latest audio devices'),
(5,'Accessories','USB Cables, Mobile chargers and Keyboards etc')

GO

SET IDENTITY_INSERT dbo.Categories OFF 
GO

SET IDENTITY_INSERT dbo.products ON 
GO


INSERT INTO dbo.products(ProductId,CategoryId,Name,Price,ProductArtUrl)
VALUES (1,1,'Phone 12',699.00,'/Content/Images/Mobile/1.jpg'),
(2,1,'Phone 13 Pro',999.00,'/Content/Images/Mobile/2.jpg'),
(3,1,'Phone 13 Pro Max',1199.00,'/Content/Images/Mobile/3.jpg'),
(4,2,'XTS 13',899.00,'/Content/Images/Laptop/1.jpg'),
(5,2,'PC 15.5',479.00,'/Content/Images/Laptop/2.jpg'),
(6,2,'Notebook 14',169.00,'/Content/Images/Laptop/3.jpg'),
(7,3,'The IdeaCenter',539.00,'/Content/Images/placeholder.gif'),
(8,3,'COMP 22-df003w',389.00,'/Content/Images/placeholder.gif'),
(9,4,'Bluetooth Headphones Over Ear',28.00,'/Content/Images/Headphones/1.png'),
(10,4,'ZX Series ',10.00,'/Content/Images/Headphones/2.png'),
(11,5,'Wireless charger',9.99,'/Content/Images/placeholder.gif'),
(12,5,'Mousepad',2.99,'/Content/Images/placeholder.gif'),
(13,5,'Keyboard',9.99,'/Content/Images/placeholder.gif')

SET IDENTITY_INSERT dbo.products OFF
GO






