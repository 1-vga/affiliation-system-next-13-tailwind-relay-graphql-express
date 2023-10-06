import loadSerializableQuery from "src/relay/load-serializable-query"
import MainViewQueryNode, { mainViewQuery } from "__generated__/mainViewQuery.graphql"
import MainViewClientComponent from "./main-view-client-component"

const Page = async () => {
  const preloadedQuery = await loadSerializableQuery<typeof MainViewQueryNode, mainViewQuery>(MainViewQueryNode.params, {})
  return <MainViewClientComponent preloadedQuery={preloadedQuery} />
}

export default Page

export const revalidate = 0
