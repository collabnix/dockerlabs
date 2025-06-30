// src/streamedQuery.ts
import { addToEnd } from "./utils.js";
function streamedQuery({
  queryFn,
  refetchMode = "reset",
  maxChunks
}) {
  return async (context) => {
    const query = context.client.getQueryCache().find({ queryKey: context.queryKey, exact: true });
    const isRefetch = !!query && query.state.data !== void 0;
    if (isRefetch && refetchMode === "reset") {
      query.setState({
        status: "pending",
        data: void 0,
        error: null,
        fetchStatus: "fetching"
      });
    }
    let result = [];
    const stream = await queryFn(context);
    for await (const chunk of stream) {
      if (context.signal.aborted) {
        break;
      }
      if (!isRefetch || refetchMode !== "replace") {
        context.client.setQueryData(
          context.queryKey,
          (prev = []) => {
            return addToEnd(prev, chunk, maxChunks);
          }
        );
      }
      result = addToEnd(result, chunk, maxChunks);
    }
    if (isRefetch && refetchMode === "replace" && !context.signal.aborted) {
      context.client.setQueryData(context.queryKey, result);
    }
    return context.client.getQueryData(context.queryKey);
  };
}
export {
  streamedQuery
};
//# sourceMappingURL=streamedQuery.js.map