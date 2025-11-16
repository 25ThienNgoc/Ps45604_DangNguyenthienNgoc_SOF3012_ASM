-- Y2.1: SCRIPT TẠO CSDL
-- Hệ quản trị CSDL: SQL Server 2008+

-- 1. TẠO CSDL
CREATE DATABASE OnlineEntertainment;
GO
USE OnlineEntertainment;
GO

-- 2. Bảng User
CREATE TABLE [User] (
    Id VARCHAR(20) PRIMARY KEY,
    Password VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Fullname NVARCHAR(50) NOT NULL,
    Admin BIT NOT NULL DEFAULT 0 -- 0: User, 1: Admin
);

-- 3. Bảng Video
CREATE TABLE Video (
    Id VARCHAR(20) PRIMARY KEY, -- Thường là Youtube ID
    Title NVARCHAR(50) NOT NULL,
    Poster VARCHAR(255), -- Link ảnh
    [Views] INT NOT NULL DEFAULT 0,
    Description NVARCHAR(1000),
    Active BIT NOT NULL DEFAULT 1 -- 1: Hiển thị, 0: Ẩn/Xóa mềm (Soft Delete)
);

-- 4. Bảng Favorite (Video Yêu thích)
CREATE TABLE Favorite (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId VARCHAR(20) NOT NULL,
    VideoId VARCHAR(20) NOT NULL,
    LikeDate DATETIME NOT NULL DEFAULT GETDATE(),

    -- Ràng buộc khóa ngoại
    FOREIGN KEY (UserId) REFERENCES [User](Id) ON DELETE CASCADE,
    FOREIGN KEY (VideoId) REFERENCES Video(Id) ON DELETE CASCADE,
    
    -- Ràng buộc: Mỗi user chỉ like 1 video 1 lần
    UNIQUE (UserId, VideoId) 
);

-- 5. Bảng Share (Video Chia sẻ)
CREATE TABLE Share (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId VARCHAR(20) NOT NULL,
    VideoId VARCHAR(20) NOT NULL,
    Emails NVARCHAR(255) NOT NULL, -- Email người nhận
    ShareDate DATETIME NOT NULL DEFAULT GETDATE(),

    -- Ràng buộc khóa ngoại
    FOREIGN KEY (UserId) REFERENCES [User](Id) ON DELETE CASCADE,
    FOREIGN KEY (VideoId) REFERENCES Video(Id) ON DELETE CASCADE
);

-- 6. DỮ LIỆU MẪU BAN ĐẦU
INSERT INTO [User] (Id, Password, Email, Fullname, Admin) VALUES
('admin', '123', 'admin@oe.com', N'Quản Trị Viên', 1),
('user1', '123', 'user1@oe.com', N'Nguyễn Văn A', 0),
('user2', '123', 'user2@oe.com', N'Trần Thị B', 0);

INSERT INTO Video (Id, Title, Poster, Description, Views) VALUES
('h0eC90p3S8M', N'Tiểu Phẩm Hài 1', 'img/poster1.jpg', N'Mô tả hài hước về cuộc sống.', 500),
('r9d-r31D7wI', N'Tiểu Phẩm Hài 2', 'img/poster2.jpg', N'Tiểu phẩm mới nhất năm 2024.', 850),
('l3pG25b8VzT', N'Tiểu Phẩm Hài 3', 'img/poster3.jpg', N'Video hài lãng mạn.', 300),
('q8wZ1xC9YfU', N'Tiểu Phẩm Hài 4', 'img/poster4.jpg', N'Hài độc thoại.', 1200),
('a4vB6oD2wE8', N'Tiểu Phẩm Hài 5', 'img/poster5.jpg', N'Hài kịch cổ điển.', 600),
('j7kL9mN5pQ2', N'Tiểu Phẩm Hài 6', 'img/poster6.jpg', N'Ghi hình trực tiếp.', 450);

INSERT INTO Favorite (UserId, VideoId) VALUES
('user1', 'r9d-r31D7wI'),
('user1', 'h0eC90p3S8M'),
('user2', 'r9d-r31D7wI'),
('user2', 'q8wZ1xC9YfU'),
('admin', 'r9d-r31D7wI');

INSERT INTO Share (UserId, VideoId, Emails) VALUES
('user1', 'h0eC90p3S8M', 'friend1@example.com'),
('user2', 'q8wZ1xC9YfU', 'friend2@example.com');