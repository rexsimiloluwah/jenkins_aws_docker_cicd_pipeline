const express = require('express')

const app = express()
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('Hello World. From Jenkins (Updated)')
})

app.get('/healthcheck', (req, res) => {
    res.status(200).json({
        status: true, 
        message: "Server is healthy!"
    })
})

app.listen(port, () => {
    console.log(`Server is listening on port ${port}`)
})