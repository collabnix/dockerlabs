---
title: "Set your OpenAI API key"
---

Enabling RAG in cagent is as simple as adding a rag section to your config. Here's a basic example.

## Step 1. Clone the repo

```
git clone https://github.com/ajeetraina/cagent-rag-demo/
cd cagent-rag-demo
```

## Step 2. Get OpenAI API Key

```

export OPENAI_API_KEY=your-key-here
```

## Step 3. Verify the YAML file

```
rag:
  codebase:
    docs: [./src, ./pkg]
    strategies:
      - type: chunked-embeddings
        embedding_model: openai/text-embedding-3-small
        vector_dimensions: 1536
        database: ./embeddings.db
        limit: 20
        chunking:
          size: 1500
          overlap: 150
      - type: bm25
        database: ./bm25.db
        limit: 15
    results:
      fusion:
        strategy: rrf
        k: 60
      deduplicate: true
      limit: 5

agents:
  root:
    model: openai/gpt-4
    instruction: |
      You are a Go developer. Search the codebase before answering.
      Reference specific files and functions.
    rag: [codebase]
```


```
cagent run cagent-config.yaml
```

This config indexes ./src and ./pkg using two strategies: 

- chunked-embeddings converts code into vectors for semantic search (finding "authentication" when you search "login"), while bm25 does keyword matching (finding exact function names like HandleRequest).

Chunks are 1500 characters with 150-character overlap to preserve context at boundaries. Both strategies run in parallel-embeddings returns up to 20 results, bm25 up to 15. RRF fusion merges them by rank (not score), deduplicates, and returns the top 5. The agent gets a search tool linked to this index and is instructed to search before answering.


## How it works?

This is a RAG (Retrieval-Augmented Generation) config for cagent. Here's what each section does:

```
rag: - The knowledge base
yamldocs: [./src, ./pkg]          # Index these 2 directories (your Go source code)
```

Two retrieval strategies running in parallel:

| strategy | How it works |
|----------|-------------|
| chunked-embeddings | Splits code into 1500-char chunks (150 overlap), converts to vectors via OpenAI embeddings, finds top 20 semantically similar chunks |
| bm25 | Keyword-based search (like grep but smarter), finds top 15 matches by term frequency |

results: - How results are merged

```
fusion:
  strategy: rrf    # Reciprocal Rank Fusion - combines both rankings
  k: 60           # Smoothing factor (higher = more equal weighting)
deduplicate: true  # Remove duplicate chunks
limit: 5          # Feed only the best 5 chunks to the LLM
```
So: 20 embedding results + 15 BM25 results → fused → deduped → top 5 sent to GPT-4.

