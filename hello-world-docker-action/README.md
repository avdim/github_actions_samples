# Hello world docker action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

### `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

### `time`

The time we greeted you.

## Example usage

```yaml
- uses: avdim/github_actions_samples/hello-world-docker-action@master
  with:
    who-to-greet: 'Mona the Octocat'
- name: Get the output time
  run: echo "The time was ${{ steps.hello.outputs.time }}"
  ```
