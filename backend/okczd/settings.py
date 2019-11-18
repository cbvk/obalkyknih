import pathlib
import yaml

BASE_DIR = pathlib.Path(__file__).parent.parent
config_path_priority = BASE_DIR / 'okczd/priority.yaml'

def get_config(path):
    with open(path) as f:
        config = yaml.load(f)
    return config

priority = get_config(config_path_priority)
