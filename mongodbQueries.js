db.reviews.insertMany([
    {
        book_id: ObjectId("64db1c3a6f4e3d2f1c123456"),
        reviewer: {
            first_name: "Michael",
            last_name: "Johnson",
            email: "michael@example.com"
        },
        rating: 4,
        review_text: "Great read, though a bit repetitive at times.",
        review_date: new Date("2024-11-23"),
        is_deleted: false
    },
    {
        book_id: ObjectId("64db1c3a6f4e312f8c654321"),
        reviewer: {
            first_name: "Laura",
            last_name: "Davis",
            email: "laura@example.com"
        },
        rating: 5,
        review_text: "Exceptional book, really enjoyed it!",
        review_date: new Date("2024-11-24"),
        is_deleted: false
    }
]);


db.reviews.createIndex({ book_id: 1 });

db.reviews.find({ book_id: ObjectId("64db1c3a6f4e3d2f8c123456"), is_deleted: false })
    .sort({ review_date: -1 })  // Sort reviews by date (newest first)
    .limit(10);


    db.orders.aggregate([
        {
            $match: { status: "Completed" }  // Filter orders that are completed
        },
        {
            $lookup: {
                from: "customers",
                localField: "customer_id",
                foreignField: "_id",
                as: "customer_details"
            }
        },
        {
            $unwind: "$customer_details"
        },
        {
            $project: {
                "order_id": 1,
                "order_date": 1,
                "total_amount": 1,
                "customer_name": { $concat: ["$customer_details.first_name", " ", "$customer_details.last_name"] },
                "customer_email": "$customer_details.email"
            }
        },
        {
            $sort: { order_date: -1 }
        }
    ]);

    
    db.customers.insertOne({
        first_name: "Sarah",
        last_name: "White",
        email: "sarah@example.com",
        phone: "555-1234",
        address: "789 Pine Street",
        city: "San Francisco",
        country: "USA",
        orders: [
            {
                order_date: new Date("2024-11-23"),
                status: "Completed",
                total_amount: 45.00,
                books: [
                    { title: "Book 1", price: 29.99, quantity: 1 },
                    { title: "Book 2", price: 15.01, quantity: 1 }
                ]
            }
        ]
    });

    
    db.orders.createIndex({ customer_id: 1, order_date: -1 });

db.orders.find({ status: "Completed" })
    .sort({ order_date: -1 })
    .limit(5);  // Retrieves the most recent 5 completed orders
