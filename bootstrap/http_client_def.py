def http_client_def():
    return """\
import logging
from aiohttp import ClientResponse, ClientError
from typing import Optional, Any, Dict, Callable

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class HTTPClient:
    def __init__(self, 
                 base_url: Optional[str] = None,
                 default_headers: Optional[Dict[str, str]] = None,
                 timeout: Optional[int] = 10,
                 max_retries: Optional[int] = 3,
                 backoff_factor: Optional[float] = 0.5):
        self.session = None  # Initialize without a session
        self.base_url = base_url
        self.default_headers = default_headers or {}
        self.timeout = aiohttp.ClientTimeout(total=timeout)
        self.max_retries = max_retries
        self.backoff_factor = backoff_factor

    async def __aenter__(self):
        await self.init()
        return self

    async def __aexit__(self, exc_type, exc, tb):
        await self.close()

    async def init(self):
        if self.session is None:
            self.session = aiohttp.ClientSession(
                headers=self.default_headers,
                timeout=self.timeout
            )
            logger.info("HTTPClient session initialized.")

    async def request(self, method: str, url: str, **kwargs) -> ClientResponse:
        if self.session is None:
            await self.init()
        
        full_url = f"{self.base_url}{url}" if self.base_url else url

        for attempt in range(1, self.max_retries + 1):
            try:
                logger.info(f"Attempt {attempt}: {method.upper()} {full_url}")
                async with self.session.request(method, full_url, **kwargs) as response:
                    response_body = await response.text()
                    response.body = response_body  # Attach body to response
                    if response.status >= 400:
                        logger.error(f"HTTP Error {response.status}: {response.reason}")
                        response.raise_for_status()
                    return response
            except (ClientError, asyncio.TimeoutError) as e:
                logger.warning(f"Request failed: {e}. Retrying in {self.backoff_factor * attempt} seconds...")
                await asyncio.sleep(self.backoff_factor * attempt)
        logger.error(f"All {self.max_retries} attempts failed for {method.upper()} {full_url}")
        raise Exception(f"Failed to perform {method.upper()} request to {full_url}")

    async def get(self, url: str, params: Optional[Dict[str, Any]] = None, **kwargs) -> ClientResponse:
        return await self.request('GET', url, params=params, **kwargs)
    
    async def post(self, url: str, data: Optional[Any] = None, json: Optional[Any] = None, **kwargs) -> ClientResponse:
        return await self.request('POST', url, data=data, json=json, **kwargs)
    
    async def put(self, url: str, data: Optional[Any] = None, **kwargs) -> ClientResponse:
        return await self.request('PUT', url, data=data, **kwargs)
    
    async def delete(self, url: str, **kwargs) -> ClientResponse:
        return await self.request('DELETE', url, **kwargs)
    
    async def patch(self, url: str, data: Optional[Any] = None, **kwargs) -> ClientResponse:
        return await self.request('PATCH', url, data=data, **kwargs)
    
    async def head(self, url: str, **kwargs) -> ClientResponse:
        return await self.request('HEAD', url, **kwargs)
    
    async def options(self, url: str, **kwargs) -> ClientResponse:
        return await self.request('OPTIONS', url, **kwargs)
    
    async def get_json(self, url: str, params: Optional[Dict[str, Any]] = None, **kwargs) -> Any:
        response = await self.get(url, params=params, **kwargs)
        try:
            return await response.json()
        except aiohttp.ContentTypeError:
            logger.error("Response is not in JSON format.")
            raise
    
    async def post_json(self, url: str, json: Optional[Any] = None, **kwargs) -> Any:
        response = await self.post(url, json=json, **kwargs)
        try:
            return await response.json()
        except aiohttp.ContentTypeError:
            logger.error("Response is not in JSON format.")
            raise

    async def close(self):
        if self.session:
            await self.session.close()
            logger.info("HTTPClient session closed.")

# Instantiate a global HTTPClient with default settings
http = HTTPClient(
    base_url=None,  # Set a base URL if needed
    default_headers={"User-Agent": "CustomHTTPClient/1.0"},
    timeout=10,
    max_retries=3,
    backoff_factor=0.5
)
"""
