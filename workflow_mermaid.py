import yaml

with open(".github/workflows/build.yml") as file:
    workflow = yaml.load(file)

    for key, value in workflow.items():
        if key is True:
            print(value)
            print(key)