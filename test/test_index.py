from src.index import Index
from unittest import TestCase

class TestIndex(TestCase):

    def test_given_when_hello_world_is_called_return_hello(self):
        self.assertEqual (Index.hello_world(self), "hello")