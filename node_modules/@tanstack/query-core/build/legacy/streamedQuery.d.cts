import { I as QueryKey, a1 as QueryFunctionContext, Y as QueryFunction } from './hydration-CdBkFt9i.cjs';
import './removable.cjs';
import './subscribable.cjs';

/**
 * This is a helper function to create a query function that streams data from an AsyncIterable.
 * Data will be an Array of all the chunks received.
 * The query will be in a 'pending' state until the first chunk of data is received, but will go to 'success' after that.
 * The query will stay in fetchStatus 'fetching' until the stream ends.
 * @param queryFn - The function that returns an AsyncIterable to stream data from.
 * @param refetchMode - Defines how re-fetches are handled.
 * Defaults to `'reset'`, erases all data and puts the query back into `pending` state.
 * Set to `'append'` to append new data to the existing data.
 * Set to `'replace'` to write all data to the cache once the stream ends.
 * @param maxChunks - The maximum number of chunks to keep in the cache.
 * Defaults to `undefined`, meaning all chunks will be kept.
 * If `undefined` or `0`, the number of chunks is unlimited.
 * If the number of chunks exceeds this number, the oldest chunk will be removed.
 */
declare function streamedQuery<TQueryFnData = unknown, TQueryKey extends QueryKey = QueryKey>({ queryFn, refetchMode, maxChunks, }: {
    queryFn: (context: QueryFunctionContext<TQueryKey>) => AsyncIterable<TQueryFnData> | Promise<AsyncIterable<TQueryFnData>>;
    refetchMode?: 'append' | 'reset' | 'replace';
    maxChunks?: number;
}): QueryFunction<Array<TQueryFnData>, TQueryKey>;

export { streamedQuery };
