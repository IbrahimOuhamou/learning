<script>
    let count = $state(1);
    const subhana_allah_names = [
        'la ilaha illa Allah',
        'subhana Allah wa bihamdihi',
    ];
    let names = $state([]);
</script>


<h3>Count</h3>

{#each [1, 2, 3] as count_it}
    <label>
        <input
            type="radio"
            value={count_it}
            bind:group={count}
        >

        {count_it} count
    </label>
{/each}

<h3>Name</h3>

{#each subhana_allah_names as name}
    <label>
        <input
            type="checkbox"
            value={name}
            bind:group={names}
        >
        {name}
    </label>
{/each}

<select multiple bind:value={names}>
{#each subhana_allah_names as name}
    <option>{name}</option>
{/each}
</select>

<p>
    You selected  {#if count > 1} {count} ones{:else}one{/if} and chose:
    "{names}"
</p>

