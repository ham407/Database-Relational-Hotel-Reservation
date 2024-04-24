-- 1. Buat tabel customer --
CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR (100),
	phone VARCHAR (100)
);

-- 2. Buat table reservasi--
CREATE TABLE reservation(
	reservation_id INT PRIMARY KEY,
	customer_id INT NOT NULL,
	reservation_date TIMESTAMP NOT NULL,
	start_date TIMESTAMP NOT NULL,
	end_date TIMESTAMP NOT NULL,
	total_price NUMERIC NOT NULL,
	CONSTRAINT ck_totalprice
		CHECK (total_price > 0),
	CONSTRAINT fk_customer
		FOREIGN KEY (customer_id)
		REFERENCES customer(customer_id)
		ON DELETE NO ACTION
);

-- 3. Buat table payment
CREATE TABLE payment(
	payment_id INT PRIMARY KEY,
	reservation_id INT NOT NULL,
	provider VARCHAR(100) NOT NULL,
	account_number VARCHAR(100) NOT NULL,
	payment_status VARCHAR(20) NOT NULL,
	payment_date TIMESTAMP,
	expire_date TIMESTAMP NOT NULL
	CHECK (payment_status in ('Waiting', 'Success', 'Failed')),
	CONSTRAINT fk_reservation
		FOREIGN KEY (reservation_id)
		REFERENCES reservation(reservation_id)
		ON DELETE CASCADE
);

-- 4. Buat tabel room_type
CREATE TABLE room_type(
	room_type_id INT PRIMARY KEY,
	name_type VARCHAR(20) NOT NULL,
	max_occupacy INT NOT NULL,
	price NUMERIC NOT NULL,
	description TEXT,
	CHECK (price > 0)
);

-- 5. Buat tabel room
CREATE TABLE room (
	room_id INT PRIMARY KEY,
	room_type_id INT NOT NULL,
	room_floor INT NOT NULL,
	availability BOOLEAN NOT NULL,
	CONSTRAINT fk_roomtype
		FOREIGN KEY (room_type_id)
		REFERENCES room_type(room_type_id)
		ON DELETE NO ACTION	
);

-- 5. Buat tabel amenity
CREATE TABLE amenity(
	amenity_id INT PRIMARY KEY,
	room_type_id INT NOT NULL,
	bed_type VARCHAR(20) NOT NULL,
	size VARCHAR(25),
	air_conditioner BOOLEAN,
	refrigerator BOOLEAN,
	microwave BOOLEAN,
	coffe_machine BOOLEAN,
	television BOOLEAN,
	jacuzzi BOOLEAN,
	CONSTRAINT fk_roomtype
		FOREIGN KEY (room_type_id)
		REFERENCES room_type(room_type_id)
		ON DELETE RESTRICT
);


-- 6. Buat table reservtion_room
CREATE TABLE reservation_room(
	reservation_room INT PRIMARY KEY,
	reservation_id INT NOT NULL,
	room_id INT NOT NULL,
	CONSTRAINT fk_reservation
		FOREIGN KEY (reservation_id)
		REFERENCES reservation(reservation_id)
		ON DELETE CASCADE,
	CONSTRAINT fk_room
		FOREIGN KEY (room_id)
		REFERENCES room(room_id)
		ON DELETE NO ACTION
);

SELECT * FROM customer;

-- Insert : GAGAL
INSERT INTO reservation(reservation_id, customer_id, reservation_date, start_date, end_date, total_price)
VALUES('14006131', 2, NULL, '2017-09-10 12:00:00+03', '2017-09-12 13:00:00+03', 1974000);

-- Insest : BERHASIL
INSERT INTO reservation(reservation_id, customer_id, reservation_date, start_date, end_date, total_price)
VALUES('140061301', 1, '2017-09-08 12:00:00+03', '2017-09-10 12:00:00+03', '2017-09-12 13:00:00+03', 1974000);
