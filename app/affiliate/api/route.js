import { cookies } from 'next/headers'
import { uuid } from 'uuidv4';

export async function GET(request) {

    console.log(request)
    const requestCookies = cookies()
    const ref = requestCookies.get('ref')?.value || uuid()

    const body = JSON.stringify({
        sample_data: `http://localhost:3000/account?ref=${ref}`,
    })

    return new Response(body, {
        status: 200,
        headers: { 'Set-Cookie': `ref=${ref}` },
    })
}