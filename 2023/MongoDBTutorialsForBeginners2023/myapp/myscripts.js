//    /*
db.students.insertOne({
    name: 'Nguyen Duc Hoang',
    dateOfBirth: new Date('1979-10-25'),
    email: 'sunlight4d@gmail.com',
    address: 'Bachmai street, Hanoi, Vietnam'
})

db.students.insertMany([
    {
        name: 'Firgo',
        dateOfBirth: new Date('1993-10-22'),
        email: 'firgo12@gmail.com',
        address: 'street A, road B, Sweden'
    },
    {
        name: 'Peter Norton',
        dateOfBirth: new Date('2000-02-11'),
        email: 'peternotrotn@gmail.com',
        address: 'somewhere in the world'
    },
])
db.students.find()

//schema validation
/*
db.createCollection('courses', {
    validator: {
        $jsonSchema:{
            bsonType: 'object', //binary json(Javascript Object Notation)
            title: 'Validate Course object',
            properties: {
                title: {
                    bsonType: 'string',
                    description: "title must be a string"                    
                },
                hours: {
                    bsonType: 'int',
                    minimum: 3,
                    maximum: 100,
                    description: "hours must be between 3 and 100"                    
                },
                startDate: {
                    bsonType: ['date'],
                    description: 'Incorrect date type'
                },
                price: {
                    bsonType: ['int', 'double'],
                    description: 'price must be a number'
                }
            }
        }
    }
})
*/
/*
db.courses.insertOne({
    title: 'Java programming language for beginners',
    hours: 50,
    startDate: new Date('2023-02-10')
})

db.courses.insertOne({
    title: 'Mobile game with Unity',
    hours: 90,
    startDate: new Date('2023-02-10'),
    price: 123.2
})
*/
//db.courses.find().limit(1)
//Get detail validations ?

//Update schema validation
/*
db.runCommand({
    collMod: "courses", //collection modify
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            properties: {
                hours: {
                    bsonType: 'int',
                    minimum: 3,
                    maximum: 200,
                    description: "hours must be between 3 and 200"                    
                },
            }
        }
    }
})
*/
//db.getCollectionInfos({name: 'courses'})[0].options.validator["$jsonSchema"].properties
//data is small, please import sample data

//use sample_mflix
//show collections
//show movies which has year in [2000, 2018]
db.movies.find({
    year: {
        $gte: 2016, //greater than or equals
        $lte: 2018, //less than or equals 
    }
}, {
    plot: 1,
    year: 1,    
})
//which movies' types we have:
db.movies.distinct("type")
db.movies.find({
    "tomatoes.viewer.rating": 5
}, {
    tomatoes: 1
})

db.movies.find({
    "tomatoes.viewer.rating": {
        $gte: 5
    }
}, {
    tomatoes: 1
})
//what is the maximum of "tomatoes.viewer.rating"
db.movies.find({
    "tomatoes.viewer.rating": {
        $exists:true
    }
}).sort({"tomatoes.viewer.rating": -1}).limit(1)
//what is the min of "tomatoes.viewer.rating"
db.movies.find({
    "tomatoes.viewer.rating": {
        $exists:true
    }
}).sort({"tomatoes.viewer.rating": 1}).limit(1)
db.movies.find({
    directors: {
        $in: ["William K.L. Dickson", "Edwin S. Porter"]
    }
}, {
    title: 1,
    year: 1,
    directors: 1
})
//show all movies which has only 1 director
db.movies.find({
    directors: {
        $size: 1
    }
}, {
    title: 1,
    year: 1,
    directors: 1
})
//find by Id

db.movies.find({
    _id: ObjectId("573a1390f29313caabcd680a"),
})
//calculated fields
db.movies.find({}, {
    title: 1,
    year: 1,
    directors: 1,
    numberOfDirectors: {$size: "$directors"}
})
//skip, limit => paging
//first page, 5 items
db.movies.find({},{title: 1}).skip(0).limit(5)
//second page
db.movies.find({},{title: 1}).skip(5).limit(5)
//third page
db.movies.find({},{title: 1}).skip(10).limit(5)
//forth page
db.movies.find({},{title: 1}).skip(15).limit(5)
//Aggregate, something better than "find"
//PIPELINE !
db.movies.aggregate([
    //stage 1
    {
        $match: {
            _id: ObjectId("573a1390f29313caabcd680a")
        }
    },    
    //stage 2
    {
        $project: {
            _id: 0,
            title: 1,
            year: 1,
            directors: 1
        }
    }    
])
db.comments.aggregate(
    {
        $match: {
            email: 'sophie_turner@gameofthron.es'
        }
    }
).toArray().length
//and, or, ...
db.movies.aggregate([
    //stage 1
    {
        $match: {
            $and: [                
                {
                    type: 'movie'
                },
                {
                    year: {
                        $in: [1917, 1997]
                    }
                }
                /*
                {
                    $or: [
                        {
                            year: 1917
                        },
                        {
                            year: 1997
                        }
                    ]
                }
                */
            ]
        }
    },
    //stage 1
    {
        $project: {
            title: 1,
            year: 1,
            type: 1
        }
    }
]).toArray().length
//2 movies has Many comments
db.comments.aggregate([
    {
        $group: {
            _id: "$movie_id",
            numberOfComments: {
                $count: {}
            }
        }
    },  
    {
        $lookup: {
            from: "movies",
            localField: "_id",
            foreignField: "_id",
            as: "detailMovie"
        }
    } 
])
db.comments.aggregate([
    {
        $match: {
            //i = ignore case
            //text: /.*Veritatis eos impedit.*/i //text contains ...
            //text: /^Nihil asperiores.*/i //text starts with ...
            text: /.*reprehenderit error\.$/i //text ends with ...
        }
    },
    {
        $sort: {
            name: -1
        }
    }
])
//Add more fields to the stage
db.movies.aggregate([
    //stage 1
    {
        $match: {
            writers: {$exists: true},
            awards: {$exists: true},
        }
    },
    //stage 2
    {
        $addFields: {
            numberOfWriters: {$size: "$writers"},
            numberOfAwards: "$awards.wins"
        }
    },
    {
        $match: {
            numberOfAwards: {$gt: 1}
        }
    }
])
//Find movies with more than 1 genres
db.movies.aggregate([
    {
        $match: {
            "genres.1": {
                //second item of genres is "exist"
                $exists: true
            }
        }
    }
])
//unwind => flattern
db.movies.aggregate([
    {
        $unwind: "$genres"
    }
]).toArray().length

//no "unwind"
db.movies.aggregate([
        
]).toArray().length

db.movies.updateOne({
    _id: ObjectId("573a1390f29313caabcd548c"),    
}, {
    $set: {
        year: 1916,
        "imdb.rating": 6.9,        
    },
    $currentDate: {lastupdated: true}
})
db.movies.replaceOne({
    _id: ObjectId("573a1390f29313caabcd548c"),    
}, {
    year: 1916,
    "imdb.rating": 6.9,        
}, {
    upsert: true //insert if not found
})
//try with replaceOne, updateMany
db.movies.find({
    _id: ObjectId("573a1390f29313caabcd548c"),    
})
db.movies.deleteMany({
    _id: ObjectId("573a1390f29313caabcd548c"),    
})