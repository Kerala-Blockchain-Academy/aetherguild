<script lang="ts">
  let address = $state('')

  const requestTETH = async (e: Event) => {
    e.preventDefault()
    try {
      if (address.length != 42 || address.substring(0, 2) != '0x') {
        alert('Invalid address. Check the value.')
        return
      }

      const formData = new FormData()
      formData.append('address', address)

      const response = await fetch('credit', {
        method: 'POST',
        body: formData,
      })

      if (response.ok) {
        alert(`Credited 1 TETH successfully to ${address}!!`)
        address = ''
      } else {
        alert(`Error: ${await response.json()}`)
      }
    } catch (error) {
      alert(`Error: ${error}`)
    }
  }
</script>

<main>
  <form
    class="max-w-screen-md mx-auto m-6 p-6 bg-white border border-gray-200 rounded-lg shadow"
    action="/credit"
    onsubmit={requestTETH}
  >
    <h1 class="text-2xl m-4 text-center">AetherGuild - Druid Faucet</h1>
    <label for="address" class="block mb-2 text-l font-medium text-gray-900"
      >Your Ethereum Address</label
    >
    <input
      type="text"
      id="address"
      class="bg-gray-50 border border-gray-300 text-gray-900 text-md rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full my-4 p-4"
      placeholder="0x..."
      required
      bind:value={address}
    />
    <button
      type="submit"
      class="text-gray-200 bg-gray-800 hover:bg-gray-600 focus:ring-4 focus:outline-none focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center me-2 mb-2"
    >
      <svg
        class="w-4 h-4 me-2 -ms-1 text-gray-500"
        aria-hidden="true"
        focusable="false"
        data-prefix="fab"
        data-icon="ethereum"
        role="img"
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 320 512"
        ><path
          fill="currentColor"
          d="M311.9 260.8L160 353.6 8 260.8 160 0l151.9 260.8zM160 383.4L8 290.6 160 512l152-221.4-152 92.8z"
        ></path></svg
      >
      Get TETH
    </button>
  </form>
</main>
