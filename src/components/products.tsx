import Link from "next/link"
import { useCallback } from "react"
import { graphql, usePaginationFragment } from "react-relay"
import { productsFragment$key } from "__generated__/productsFragment.graphql"
import { productsPaginationQuery } from "__generated__/productsPaginationQuery.graphql"

export default function Products(props: { parentFragmentRef: productsFragment$key | null | undefined }) {
  const { data, hasNext, loadNext, isLoadingNext, refetch } = usePaginationFragment<productsPaginationQuery, productsFragment$key>(
    graphql`
      fragment productsFragment on base_company
      @argumentDefinitions(
        endCursor: { type: "String" }
        count: { type: "Int", defaultValue: 1 }
      )
      @refetchable(queryName: "productsPaginationQuery") {
        products_connection(after: $endCursor, first: $count, order_by: {title: asc})
          @connection(key: "product__products_connection") {
          pageInfo {
            endCursor
            hasNextPage
            hasPreviousPage
            startCursor
          }
          edges {
            node {
              title
              price
              product_url
              product_guid
              product_affiliate {
                affiliate {
                  username
                  affiliate_guid
                }
              }
            }
          }
        }
      }
    `,
    props.parentFragmentRef || null
  )

  // Callback to paginate the products list
  const loadMore = useCallback(() => {
    // Don't fetch again if we're already loading the next page
    if (isLoadingNext) {
      return
    }
    hasNext && loadNext(2)
  }, [hasNext, isLoadingNext, loadNext])

  const onClick = async (product_guid?: string | undefined) => {
    if (!product_guid) return

    try {
      fetch(`http://localhost:3000/api/track?ref=${product_guid}`)
    } catch (err) {
      console.log(err)
    }
  }

  return <ul className="list-disc">
    <li key={1} className="flex">
      <span className="flex-1 w-1/2">Product title</span>
      <span className="flex-1 w-1/6">Affiliate</span>
      <span className="flex-1 w-1/6">Price</span>
      <span className="flex-1 w-1/6 grow-0"></span>
    </li>
    {data?.products_connection.edges?.map(edge => (edge == null || edge.node == null)
      ? null
      : <li key={edge.node.title} className="flex">
        <span className="flex-1 w-1/2">{edge.node.title}</span>
        <span className="flex-1 w-1/6">{edge.node.product_affiliate?.affiliate.username}</span>
        <span className="flex-1 w-1/6">{edge.node.price.toLocaleString('fr-FR', { style: 'currency', currency: 'EUR' })}</span>
        <Link href={`http://localhost:3000/account?product_guid=${edge.node.product_guid}`} onClick={() => onClick(edge.node.product_affiliate?.affiliate.affiliate_guid)} className="flex-1 w-1/6 grow-0 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Buy</Link>{" "}
      </li>
    )}
    <li>
      <button onClick={loadMore} disabled={isLoadingNext} className="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded">
        {isLoadingNext ? "Loading (client side)..." : "Load 2 more"}
      </button>
      <button onClick={() => refetch({ count: 20, })} className="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded">
        Refetch 20 products
      </button>
    </li>
  </ul>
}
