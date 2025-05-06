USE Minimart;

-- Categories
INSERT INTO Categories (CategoryName, CategoryDescription) VALUES
('Fruits', 'Fresh fruits from local farms'),
('Dairy', 'Milk, cheese, and other dairy products'),
('Snacks', 'Chips, biscuits, and packaged snacks'),
('Vegetables', 'Green, leafy and fresh vegetables'),
('Beverages', 'Juices, soft drinks and bottled water'),
('Bakery', 'Breads, cakes and pastries'),
('Frozen', 'Frozen ready-to-eat meals and ice cream'),
('Meat', 'Fresh and processed meat products');

-- Suppliers
INSERT INTO Suppliers (SupplierName, SupplierPhoneNumber, SupplierAddress, SupplierEmail) VALUES
('FreshFarm Co.', '0912345678', '123 Farm Road', 'contact@freshfarm.com'),
('DairyDelight Ltd.', '0987654321', '456 Dairy Lane', 'support@dairydelight.com'),
('SnackWorld Inc.', '0911002233', '789 Snack Street', 'info@snackworld.com'),
('VeggieValley', '0922003344', '101 Greenhouse Blvd', 'hello@veggievalley.com'),
('BeverageHub', '0933004455', '202 Drink Plaza', 'orders@beveragehub.com'),
('BakeryBliss', '0944005566', '303 Bread Avenue', 'sales@bakerybliss.com'),
('FrozenFeast', '0955006677', '404 Frozen Road', 'support@frozenfeast.com'),
('MeatMasters', '0966007788', '505 Meat Street', 'contact@meatmasters.com');

-- Measurement Units
INSERT INTO MeasurementUnits (UnitName, UnitDescription, IsContinuous) VALUES
('Kilogram', 'Used for weight-based items', 1),
('Piece', 'Used for countable items', 0),
('Liter', 'Used for liquid items', 1),
('Packet', 'Used for packaged items', 0);

INSERT INTO ProductTypes (ProductName, ProductDescription, CategoryID, SupplierID, Price, StockAmount, MeasurementUnitID, ExpirationDurationDays, ImagePath) VALUES
('Banana', 'Ripe yellow bananas', 1, 1, 1.99, 120, 1, 7, 'banana.jpg'),
('Apple', 'Juicy red apples', 1, 1, 2.50, 100, 1, 10, 'apple.jpg'),
('Milk 1L', 'Full cream milk 1L pack', 2, 2, 2.49, 50, 3, 10, 'milk.jpg'),
('Yogurt Cup', 'Strawberry flavor', 2, 2, 1.20, 80, 2, 14, 'yogurt.jpg'),
('Potato Chips', 'Salted potato chips 150g', 3, 3, 1.50, 200, 4, 180, 'potatoes_chips.jpg'),
('Carrot', 'Fresh organic carrots', 4, 4, 0.99, 150, 1, 14, 'carrot.jpg'),
('Orange Juice', 'Freshly squeezed 1L', 5, 5, 3.49, 60, 3, 5, 'orange_juice.jpg'),
('Croissant', 'Buttery baked croissant', 6, 6, 0.80, 100, 2, 2, 'croissant.jpg'),
('Frozen Pizza', 'Cheese lovers pizza 500g', 7, 7, 5.99, 70, 4, 365, 'pizza.jpg'),
('Chicken Breast', 'Boneless chicken breast', 8, 8, 6.99, 50, 1, 3, 'chicken_breast.jpg');

INSERT INTO Tags (TagName) VALUES 
('fruit'),
('fresh'),
('crunchy'),
('dairy'),
('drink'),
('snack'),
('salty'),
('vegetable'),
('beverage'),
('juice'),
('bakery'),
('breakfast'),
('frozen'),
('meal'),
('meat');

INSERT INTO ProductTags (ProductTypeID, TagID) VALUES
(1, 1), -- Banana - fruit
(1, 2), -- Banana - fresh

(2, 1), -- Apple - fruit
(2, 3), -- Apple - crunchy

(3, 4), -- Milk 1L - dairy
(3, 5), -- Milk 1L - drink

(4, 4), -- Yogurt Cup - dairy
(4, 6), -- Yogurt Cup - snack

(5, 6), -- Potato Chips - snack
(5, 7), -- Potato Chips - salty

(6, 8), -- Carrot - vegetable
(6, 2), -- Carrot - fresh

(7, 9), -- Orange Juice - beverage
(7, 10), -- Orange Juice - juice

(8, 11), -- Croissant - bakery
(8, 12), -- Croissant - breakfast

(9, 13), -- Frozen Pizza - frozen
(9, 14), -- Frozen Pizza - meal

(10, 15), -- Chicken Breast - meat
(10, 2); -- Chicken Breast - fresh


-- Employee Roles
INSERT INTO EmployeeRoles (RoleName, RoleDescription) VALUES
('Cashier', 'Handles transactions at the counter'),
('Stock Manager', 'Manages stock and inventory'),
('Delivery Staff', 'Handles product deliveries'),
('Supervisor', 'Supervises staff and operations'),
('Admin', 'Perform CRUD operations');

-- Employees
INSERT INTO Employees (FirstName, LastName, Email, PhoneNumber, Gender, BirthDate, CitizenID, Salary, RoleID, ImagePath) VALUES
('Alice', 'Smith', 'alice@minimart.com', '0900111222', 'Female', '1990-05-01', 'C12345678', 2500.00, 5, 'women/3.jpg'),
('Bob', 'Johnson', 'bob@minimart.com', '0900333444', 'Male', '1985-11-12', 'C87654321', 2700.00, 2, 'men/3.jpg'),
('Charlie', 'Brown', 'charlie@minimart.com', '0900555666', 'Male', '1992-03-14', 'C99887766', 2400.00, 3, 'men/4.jpg'),
('Diana', 'Lopez', 'diana@minimart.com', '0900777888', 'Female', '1988-07-22', 'C11223344', 3000.00, 4, 'women/4.jpg');

-- Admins
INSERT INTO EmployeeAccounts (EmployeeID, Username, PasswordHash, Salt) VALUES
(1, 'alice', 0xD5E3A1B4D4DABEEF0023ABCD12345678D5E3A1B4D4DABEEF0023ABCD12345678, 0x00112233445566778899AABBCCDDEEFF),
(4, 'admindiana', 0xABCDABCDABCDABCDABCDABCDABCDABCDABCDABCDABCDABCDABCDABCDABCDABCD, 0xFFEEDDCCBBAA99887766554433221100);

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, ImagePath, Username, PasswordHash, Salt) VALUES
('John', 'Doe', 'john@example.com', '0911223344', 'men/0.jpg', 'johndoe', 0xDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEF, 0xAABBCCDDEEFF00112233445566778899),
('Jane', 'Miller', 'jane@example.com', '0911334455', 'women/0.jpg', 'janemiller', 0xDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEF, 0xFFEEDDCCBBAA99887766554433221100),
('Mark', 'Spencer', 'mark@example.com', '0911445566', 'men/1.jpg', 'markspencer', 0xCAFEBABECAFEBABECAFEBABECAFEBABECAFEBABECAFEBABECAFEBABECAFEBABE, 0x99887766554433221100AABBCCDDEEFF);

-- Payment Methods
INSERT INTO PaymentMethods (MethodName) VALUES
('Cash'),
('Credit Card'),
('Mobile Payment'),
('Bank Transfer');

-- Sales
INSERT INTO Sales (CustomerID, EmployeeID, PaymentMethodID, DeliveryAddress, DeliveryTime, IsPickup, OrderStatus) VALUES
(1, 1, 2, '789 Customer Ave', GETDATE(), 0, 'Completed'),
(2, 2, 1, '123 Delivery St', GETDATE(), 1, 'Confirmed'),
(3, 3, 3, '555 Mobile Lane', GETDATE(), 0, 'Processing'),
(1, 2, 4, '333 Bank Rd', GETDATE(), 0, 'Cancelled');

-- Sale Details
INSERT INTO SaleDetails (SaleID, ProductTypeID, Quantity, ProductPriceAtPurchase) VALUES
(1, 1, 3.5, 1.99),
(1, 2, 2, 2.50),
(1, 5, 1, 1.50),
(2, 3, 2, 2.49),
(2, 4, 3, 1.20),
(3, 7, 1, 3.49),
(3, 9, 2, 5.99),
(4, 6, 5, 0.99);

INSERT INTO OtpTypes(OtpTypeName, Description) VALUES
('Phone', 'Send OTP to user phones'),
('Email', 'Send OTP to user emails');