<!-- بسم الله الرحمن الرحيم -->
<!-- la ilaha illa Allah Mohammed Rassoul Allah -->

<script>
    import MyButton from './MyButton.svelte';
    import Effects from './Effects.svelte';
    import Counter from './Counter.svelte';
    import Inout from './Input.svelte';
    import Input from './Input.svelte';

    let count = $state(0);
    function increment() {
        count += 1;
    }
    let multiple = $derived(count * 2);

    let accurate_count = $state(0);

    const colors = ['bg-black', 'bg-white', 'bg-green-700'];

    // logs value on change, similar to
    // `console.log($state.snapshot(count))`
    $inspect(count);
    // can also do
    // $inspect(count).with(console.trace);
</script>

<main>
    <MyButton />
    <div>
        <label for="count">accurate number is: </label>
        <input type="number" id="count" bind:value={accurate_count}/>
    </div>
    <button onclick={increment} class="bg-stone-400 text-white p-2 rounded-md font-semibold">
        alhamdo li Allah <span class="text-red-400">{count}</span> is
        {#if count < accurate_count}
            less than {accurate_count}. click to add
        {:else if count == accurate_count}
            {accurate_count}. click to add
        {:else}
            more than {accurate_count}, but you can continue
        {/if}
        
    </button>
    <p>multiple is: {multiple}</p>
    <Effects />

    <div class="m-auto max-w-md bg-gray-200 rounded-md">
        <p class="text-lg text-center">Shared state</p>
        <div class="m-auto max-w-fit p-4">
            {#each colors as bg_color, i}
                <Counter {bg_color}/>
            {/each}
        </div>
    </div>

    <div class="m-auto max-w-md bg-gray-200 rounded-md mt-3">
        <Input />
    </div>

</main>

<style>
</style>

