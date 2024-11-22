use bookstore;

db.reviews.insertMany([
    {
        _id: ObjectId(),
        book_id: ObjectId("64db1c3a6f4e3d2f8c123456"),
        reviewer: {
            first_name: "John",
            last_name: "Doe",
            email: "john@example.com"
        },
        rating: 5,
        review_text: "Amazing book! Highly recommended.",
        review_date: new Date("2024-11-21"),
        is_deleted: false
    },
    {
        _id: ObjectId(),
        book_id: ObjectId("64db1c3a6f4e3d2f8c654321"),
        reviewer: {
            first_name: "Jane",
            last_name: "Smith",
            email: "jane@example.com"
        },
        rating: 4,
        review_text: "Very informative, but a bit lengthy.",
        review_date: new Date("2024-11-20"),
        is_deleted: false
    }
]);

db.customers.insertMany([
    {
        _id: ObjectId(),
        first_name: "Alice",
        last_name: "Johnson",
        email: "alice@example.com",
        phone: "123-456-7890",
        address: "123 Elm Street",
        city: "New York",
        country: "USA",
        orders: [
            {
                order_id: ObjectId(),
                order_date: new Date("2024-11-22"),
                status: "Completed",
                total_amount: 59.99,
                books: [
                    { title: "Book 1", price: 29.99, quantity: 1 },
                    { title: "Book 2", price: 30.00, quantity: 1 }
                ]
            }
        ]
    },
    {
        _id: ObjectId(),
        first_name: "Bob",
        last_name: "Brown",
        email: "bob@example.com",
        phone: "987-654-3210",
        address: "456 Oak Avenue",
        city: "Los Angeles",
        country: "USA",
        orders: [
            {
                order_id: ObjectId(),
                order_date: new Date("2024-11-20"),
                status: "Pending",
                total_amount: 25.50,
                books: [
                    { title: "Book 3", price: 25.50, quantity: 1 }
                ]
            }
        ]
    }
]);

db.orders.insertMany([
    {
        _id: ObjectId(),
        customer_id: ObjectId("64db1c3a6f4e3d2f8c987654"),
        order_date: new Date("2024-11-22"),
        status: "Completed",
        total_amount: 59.99,
        books: [
            { book_id: ObjectId("64db1c3a6f4e3d2f8c123456"), title: "Book 1", price: 29.99, quantity: 1 },
            { book_id: ObjectId("64db1c3a6f4e3d2f8c654321"), title: "Book 2", price: 30.00, quantity: 1 }
        ]
    },
    {
        _id: ObjectId(),
        customer_id: ObjectId("64db1c3a6f4e3d2f8c654789"),
        order_date: new Date("2024-11-20"),
        status: "Pending",
        total_amount: 25.50,
        books: [
            { book_id: ObjectId("64db1c3a6f4e3d2f8c789456"), title: "Book 3", price: 25.50, quantity: 1 }
        ]
    }
]);
