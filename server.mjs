import next from 'next'
import express from 'express'
import cookieParser from 'cookie-parser'

const port = parseInt(process.env.PORT || '3000', 10)
const dev = process.env.NODE_ENV !== 'production'
const app = next({ dev })
const handle = app.getRequestHandler()

const trackSale = (username, affiliate_guid) => {
    const query = `
    mutation SaleMutation($affiliate_guid: uuid!, $username: String) {
        insert_base_customer_one(object: { username: $username }) {
          id
          customer_guid
        }
      
        update_base_affiliate_by_pk(
          pk_columns: { affiliate_guid: $affiliate_guid }
          _inc: { commission: 1 }
        ) {
          commission
          affiliate_guid
        }
      }
      `;

    const variables = { username, affiliate_guid }
    try {
        const HTTP_ENDPOINT = process.env.NEXT_PUBLIC_REACT_APP_ENDPOINT
        console.log("HTTP_ENDPOINT", HTTP_ENDPOINT);
        fetch(
            HTTP_ENDPOINT,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    // ...jwtToken && { "Authorization": "Bearer " + jwtToken },
                },
                body: JSON.stringify({
                    query,
                    variables,
                }),
            },
        )
            .then(res => console.log(res))
            .catch(err => console.log(err))
            .finally(console.log('done'))

        console.log("after to fetch");

    } catch (err) {
        console.error("HASURA POST failed:", err);
    }

}

app.prepare().then(() => {
    const server = express()
    server.use(cookieParser())
    server.use(express.json())

    server.get('/api/track', (req, res) => {
        let ref = req.query.ref;
        const body = JSON.stringify(ref)
        res.cookie('ref', ref, { expires: new Date(Date.now() + 900000), httpOnly: true })
        return res.status(200).send(body)
    })

    server.post('/api/sale', (req, res) => {
        const username = req.body.username
        const ref = req.cookies.ref
        trackSale(username, ref)
        return res.status(200).send(JSON.stringify(username))
    })

    server.get('*', (req, res) => {
        return handle(req, res)
    })

    server.use((err, req, res, next) => {
        console.error(err.stack)
        res.status(500).send('Server error')
    })

    server.listen(3000, (err) => {
        if (err) throw err

        console.log('> Ready on http://localhost:3000')
    })
    console.log(`> Server listening at http://localhost:${port} as ${dev ? 'development' : process.env.NODE_ENV}`)
})