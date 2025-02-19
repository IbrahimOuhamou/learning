<script>
	let { data } = $props();
</script>

<p>{JSON.stringify(data.json)}</p>

<!-- {#each data.quotes as quote} -->
<!-- 	<div> -->
<!-- 		<p>"{quote.quote}"</p> -->
<!-- 		<p>- {quote.author}</p> -->
<!-- 	</div> -->
<!-- {/each} -->


