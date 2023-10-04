from setuptools import setup, find_packages

setup(
    name='the-zord',
    version='0.1',
    packages=find_packages(),
    package_data={
        'the-zord': ['libthe_zord.dylib'],
    },
    install_requires=[],
)
