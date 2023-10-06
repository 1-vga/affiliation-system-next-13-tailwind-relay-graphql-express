"use client"

import Link from "next/link"
import { useSearchParams } from "next/navigation"
import { useState } from "react"

const Root = () => {

  const [username, setUsername] = useState<string>('')
  const searchParams = useSearchParams()
  const product_guid = searchParams.get('product_guid')

  const onClick = async () => {

    try {
      const rawResponse = await fetch('http://localhost:3000/api/sale', {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ username, product_guid })
      });
      const content = await rawResponse.json();

      console.log(content);
    } catch (err) {
      console.log(err)
    }
  }

  return <>
    <h1 className="text-3xl font-bold underline">Account page</h1>
    <form className="w-full max-w-sm">
      <div className="flex items-center border-b border-blue-500 py-2">
        <input
          placeholder="Enter account name"
          onChange={e => setUsername(e.target.value)}
          className="appearance-none bg-transparent border-none w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none" type="text" aria-label="Account name" />
        <Link href={`http://localhost:3000/confirmation`} onClick={() => onClick()} className="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
          Sign Up and Buy Now
        </Link>
      </div>
    </form>
  </>
}

export default Root
