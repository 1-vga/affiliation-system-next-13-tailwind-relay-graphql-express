import { Suspense } from "react"
import { graphql, PreloadedQuery, usePreloadedQuery } from "react-relay"
import { mainViewQuery } from "__generated__/mainViewQuery.graphql"
import Products from "./products"

export default function MainView(props: { queryRef: PreloadedQuery<mainViewQuery> }) {
  const data = usePreloadedQuery(
    graphql`
    query mainViewQuery {
      base_company_connection(where: {company_guid: {_eq: "674e836a-0616-4f87-80be-6cb7249ce438"}}, order_by: {title: asc}) {
        edges {
          node {
            title
            ...productsFragment
          }
        }
      }
    }    
    `,
    props.queryRef
  )

  return <Suspense fallback="Loading (client side)...">
    <div className="max-h-screen overflow-y-auto">
      <h1 className="text-3xl font-bold underline">{data.base_company_connection.edges.at(0)?.node.title} Products Page</h1>
      <Products parentFragmentRef={data.base_company_connection.edges.at(0)?.node} />
    </div>
  </Suspense>
}