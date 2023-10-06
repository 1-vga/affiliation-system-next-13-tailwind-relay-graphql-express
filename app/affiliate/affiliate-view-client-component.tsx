"use client"

import AffiliateView from "src/components/affiliate-view"
import useSWR from "swr"

const fetcher = (url: string) => fetch(url).then((res) => res.json())

const Root = () => {
  const { data, error, isLoading } = useSWR('/affiliate/api', fetcher)

  if (error) {
    console.log(error)
    return <div>Failed to load</div>
  }
  if (isLoading) return <div>Client loading...</div>
  if (!data) return null

  return <>
    <h1 className="text-3xl font-bold underline">Affiliate link creation page</h1>
    <AffiliateView data={data} />
  </>
}

export default Root
