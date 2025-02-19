<script>
	let { data } = $props();
</script>

{#each data.quotes as quote}
	<div>
		<p>"{quote.quote}"</p>
		<p>- {quote.author}</p>
	</div>
{/each}


