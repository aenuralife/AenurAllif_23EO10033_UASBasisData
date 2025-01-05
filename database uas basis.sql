CREATE TABLE Pelanggan(
	id_pelanggan SERIAL PRIMARY KEY,
	nama_pelanggan VARCHAR(100) NOT NULL,
	alamat VARCHAR (255),
	no_telp VARCHAR (15)
);
SELECT * FROM Pelanggan;

CREATE TABLE Produk(
	id_produk SERIAL PRIMARY KEY,
	nama_produk VARCHAR (100) NOT NULL,
	harga DECIMAL(10, 2) NOT NULL
);
SELECT * FROM Produk;

CREATE TABLE Transaksi(
	id_transaksi SERIAL PRIMARY KEY,
	id_pelanggan INT REFERENCES Pelanggan (id_pelanggan),
	tanggal TIMESTAMP DEFAULT,
	CURRENT_TIMESTAMP
);
SELECT * FROM Transaksi;

CREATE TABLE Detail_Transaksi(
	id_detail SERIAL PRIMARY KEY,
	id_transaksi INT REFERENCES Transaksi (id_transaksi),
	id_produk INT REFERENCES Produk (id_produk),
	jumlah INT NOT NULL,
	total_harga DECIMAL (10, 2)NOT NULL
);
SELECT * FROM Detail_Transaksi;

BEGIN;
--insert data pelanggan
INSERT INTO Pelanggan (nama_pelanggan, alamat, no_telp)
VALUES ('Aenur Allif', 'Jl.Jambe rt06 rw02', '085726755204');
SELECT * FROM Pelanggan;
--insert data produk
INSERT INTO Produk (nama_produk, harga)
VALUES ('Kabel data Canon DSLR kamera SLR EOS', 34000 ),
		('Punning Powerbank 50000mAH 4 kabel', 109250),
		('TWS JQVITEK i12', 45900);
SELECT * FROM Produk;
--insert Transaksi
INSERT INTO Transaksi(id_pelanggan)
VALUES (1);
SELECT * FROM Transaksi;
--insert detail transaksi
INSERT INTO Detail_Transaksi(id_transaksi, id_produk, jumlah, total_harga)
VALUES (1, 1, 1, 34000),
		(1, 2, 1, 109200),
		(1, 3, 1, 45900);
SELECT * FROM Detail_Transaksi;
COMMIT;

--membuat super user
CREATE ROLE super_user WITH LOGIN PASSWORD 'password_super';
--membuat admin
CREATE ROLE admin WITH LOGIN PASSWORD 'password_admin';
--membuat user biasa
CREATE ROLE user_biasa WITH LOGIN PASSWORD 'password_user';

--memberikan hak akses super user
GRANT ALL PRIVILEGES ON DATABASE UAS_Basis TO super_user;
--memberikan hak akses admin
GRANT INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO admin;
--memberikan hak akses user biasa
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user_biasa;

--super user dapat melakukan semua dml
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO super_user;
--Admin hanya dapat insert dan update
GRANT INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO admin;
--User hanya bisa SELECT
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user_biasa;
