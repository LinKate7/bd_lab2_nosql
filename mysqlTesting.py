import MySQLdb
from faker import Faker
import random
import time
from datetime import datetime

# MySQL Connection
db = MySQLdb.connect(
    host="localhost",
    user="root",
    passwd="Gryfindor45",
    db="publishing"
)
cursor = db.cursor()

# Initialize Faker
fake = Faker()

cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
db.commit()

# Function to insert mock data for customers
def insert_customers(num_records=1000):
    customers_data = []
    for _ in range(num_records):
        first_name = fake.first_name()
        last_name = fake.last_name()
        email = fake.email()
        phone = fake.phone_number()
        address = fake.address().replace("\n", ", ")
        city = fake.city()
        country = fake.country()

        customers_data.append((
            first_name, last_name, email, phone, address, city, country
        ))

    cursor.executemany("""
        INSERT INTO customers (first_name, last_name, email, phone, address, city, country)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """, customers_data)
    db.commit()

# Function to insert mock data for orders
def insert_orders(num_records=1000):
    orders_data = []
    for _ in range(num_records):
        customer_id = random.randint(1, 1000)  # assuming customer IDs are between 1 and 1000
        order_date = fake.date_this_year()
        total_amount = round(random.uniform(20.0, 100.0), 2)
        status = random.choice(['Completed', 'Pending', 'Canceled'])

        orders_data.append((
            customer_id, order_date, total_amount, status
        ))

    cursor.executemany("""
        INSERT INTO orders (customer_id, order_date, total_amount, status)
        VALUES (%s, %s, %s, %s)
    """, orders_data)
    db.commit()

# Function to insert mock data for reviews
def insert_reviews(num_records=1000):
    reviews_data = []
    for _ in range(num_records):
        book_id = random.randint(1, 100)  # assuming book IDs are between 1 and 100
        reviewer_id = random.randint(1, 1000)  # assuming reviewer IDs are between 1 and 1000
        rating = random.randint(1, 5)
        review_text = fake.text(max_nb_chars=200)
        review_date = fake.date_this_year()

        reviews_data.append((
            book_id, reviewer_id, rating, review_text, review_date, False
        ))

    cursor.executemany("""
        INSERT INTO reviews (book_id, reviewer_id, rating, review_text, review_date, is_deleted)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, reviews_data)
    db.commit()

def insert_reviewers(num_records=1000):
    reviewers_data = []
    for _ in range(num_records):
        first_name = fake.first_name()
        last_name = fake.last_name()
        email = fake.email()
        affiliation = fake.company()

        reviewers_data.append((
            first_name, last_name, email, affiliation
        ))

    cursor.executemany("""
        INSERT INTO reviewers (first_name, last_name, email, affiliation)
        VALUES (%s, %s, %s, %s)
    """, reviewers_data)
    db.commit()

# Inserting data into the database
insert_customers(5000)  # Insert 5000 customers
insert_orders(5000)     # Insert 5000 orders
insert_reviews(5000)    # Insert 5000 reviews
insert_reviewers(5000)  # Insert 5000 reviewers

# Close the cursor and the connection
cursor.close()
db.close()

print("Mock data inserted successfully!")
